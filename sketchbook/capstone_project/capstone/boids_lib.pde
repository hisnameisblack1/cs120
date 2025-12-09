// draw a boid at the specified position, pointing forward (according to
// its velocity)
//  pos, vel - boid's position and velocity
//  r, g, b - boid's color
void drawBoid ( PVector pos, PVector vel, float r, float g, float b ) {
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(atan2(vel.y, vel.x));
  stroke(0);
  strokeWeight(1);
  fill(r, g, b);
  triangle(10, 0, -10, -5, -10, 5);
  popMatrix();
}

// determine if the boid at 'otherpos' is in the neighborhood
//  pos, vel - boid's position and velocity
//  radius, angle - define this boid's neighborhood
//  otherpos - other boid's position
// returns true if the other boid is in the neighborhood, false if not
boolean isNeighbor ( PVector pos, PVector vel, float radius, float angle, PVector otherpos ) {
  float dist = PVector.dist(pos, otherpos);
  if ( dist > radius ) { 
    return false;
  }
  float ang = PVector.angleBetween(vel, PVector.sub(otherpos, pos));
  return abs(ang) <= angle;
}



// compute the forward steering vector
// forward steering vector sends the boid in its current direction at its max speed
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
PVector computeForward ( PVector pos, PVector vel, float maxspeed ) {
  PVector forward = new PVector(vel.x, vel.y);
  forward.setMag(maxspeed);
  return forward;
}

// compute the wander steering vector
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
PVector computeWander ( PVector pos, PVector vel, float maxspeed ) {
  // desired velocity is to head for a random spot on the wander circle
  PVector future = PVector.add(pos, PVector.mult(vel, 20));
  float angle = random(0, 2*PI);
  PVector target = new PVector(future.x+30*cos(angle), future.y+30*sin(angle));
  PVector desired = PVector.sub(target, pos);
  desired.normalize();
  desired.mult(maxspeed);
  // steering vector is to turn in that direction
  return PVector.sub(desired, vel);
}

// compute the seek steering vector
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  target - position of the target
PVector computeSeek ( PVector pos, PVector vel, float maxspeed, PVector target ) {
  // desired velocity is to head for the target
  PVector desired = PVector.sub(target, pos);
  desired.normalize();
  desired.mult(maxspeed);
  // steering vector is to turn in that direction
  return PVector.sub(desired, vel);
}

// compute the arrive steering vector
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  target - position of the target
//  threshold - distance from target at which the boid starts slowing
PVector computeArrive ( PVector pos, PVector vel, float maxspeed, PVector target, float threshold ) {
  // desired velocity is to head for the target
  PVector desired = PVector.sub(target, pos);
  desired.normalize();
  if ( dist(pos.x, pos.y, target.x, target.y) > threshold ) {
    // boid is a long way from target - go at max speed
    desired.mult(maxspeed);
  } else {
    // scale the distance boid is from the target into the range 0-maxspeed
    desired.mult(map(dist(pos.x, pos.y, target.x, target.y), 0, threshold, 0, maxspeed));
  }
  // steering vector is to turn in that direction
  return PVector.sub(desired, vel);
}

// compute the pursue steering vector for a single quarry
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  quarrypos, quarryvel - position and velocity of quarry
PVector computePursue ( PVector pos, PVector vel, float maxspeed, PVector quarrypos, PVector quarryvel ) {
  // determine quarry's expected future position
  float t = dist(quarrypos.x, quarrypos.y, pos.x, pos.y)/quarryvel.mag();
  PVector target = PVector.add(quarrypos, PVector.mult(quarryvel, t));
  // desired velocity is to head for the quarry's expected future position
  PVector desired = PVector.sub(target, pos);
  desired.normalize();
  desired.mult(maxspeed);
  // steering vector is to turn in that direction
  return PVector.sub(desired, vel);
}

// compute the pursue steering vector - pursues the nearest quarry
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  quarrypos, quarryvel - positions and velocities of potential quarries
PVector computePursue ( PVector pos, PVector vel, float maxspeed, PVector[] quarrypos, PVector[] quarryvel ) {
  int minindex = -1;
  float mind = Float.MAX_VALUE;

  for ( int i = 0; i < quarrypos.length; i = i+1 ) {
    float d = dist(pos.x, pos.y, quarrypos[i].x, quarrypos[i].y);
    if ( d <= mind ) { 
      mind = d; 
      minindex = i;
    }
  }

  if ( minindex == -1 ) { 
    return new PVector(0, 0);
  } else { 
    return computePursue(pos, vel, maxspeed, quarrypos[minindex], quarryvel[minindex]);
  }
}

// compute the pursue steering vector - pursues the nearest quarry within the boid's neighborhood
//  pos, vel - position and velocity of boid
//  radius, angle - define this boid's neighborhood
//  maxspeed - boid's max speed
//  quarrypos, quarryvel - positions and velocities of potential quarries
PVector computePursue ( PVector pos, PVector vel, float radius, float angle, float maxspeed, PVector[] quarrypos, PVector[] quarryvel ) {
  int minindex = -1;
  float mind = Float.MAX_VALUE;

  for ( int i = 0; i < quarrypos.length; i = i+1 ) {
    if ( isNeighbor(pos, vel, radius, angle, quarrypos[i]) ) {
      float d = dist(pos.x, pos.y, quarrypos[i].x, quarrypos[i].y);
      if ( d <= mind ) { 
        mind = d; 
        minindex = i;
      }
    }
  }

  if ( minindex == -1 ) { 
    return new PVector(0, 0);
  } else { 
    return computePursue(pos, vel, maxspeed, quarrypos[minindex], quarryvel[minindex]);
  }
}

// compute the offset pursuit steering vector
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  quarrypos, quarryvel - position and velocity of quarry
//  offset - offset of target point relative to quarry (a positive x component
//   puts the target in front of the quarry)
PVector computeOffsetPursuit ( PVector pos, PVector vel, float maxspeed, PVector quarrypos, PVector quarryvel, PVector offset ) {
  // determine quarry's expected future position
  float t = dist(pos.x, pos.y, quarrypos.x, quarrypos.y)/vel.mag();
  PVector target = PVector.add(quarrypos, PVector.mult(quarryvel, t));
  // determine offset position
  PVector rotoffset = new PVector(offset.x, offset.y);
  rotoffset.rotate(quarryvel.heading());
  PVector offsetpos = PVector.add(quarrypos, rotoffset);
  // seek at offset position
  return computeArrive(pos, vel, maxspeed, offsetpos, 30);
}

// compute the flee steering vector 
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  target - position of the target
PVector computeFlee ( PVector pos, PVector vel, float maxspeed, PVector target ) {
  // flee is the opposite of seek
  // desired velocity is to away from the target
  PVector desired = PVector.sub(pos, target);
  desired.normalize();
  desired.mult(maxspeed);
  // steering vector is to turn in that direction
  return PVector.sub(desired, vel);
}

// compute the evade steering vector 
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  pursuerpos, pursuervel - position and velocity of pursuer
PVector computeEvade ( PVector pos, PVector vel, float maxspeed, PVector pursuerpos, PVector pursuervel ) {
  // evade is the opposite of pursue
  // determine pursuer's expected future position
  float t = dist(pursuerpos.x, pursuerpos.y, pos.x, pos.y)/pursuervel.mag();
  PVector target = PVector.add(pursuerpos, PVector.mult(pursuervel, t));
  // desired velocity is to head away from the pursuer's expected future position
  PVector desired = PVector.sub(pos,target);
  desired.normalize();
  desired.mult(maxspeed);
  // steering vector is to turn in that direction
  return PVector.sub(desired, vel);
}

// compute the evade steering vector - evades the nearest pursuer
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  pursuerpos, pursuervel - positions and velocities of potential quarries
PVector computeEvade ( PVector pos, PVector vel, float maxspeed, PVector[] pursuerpos, PVector[] pursuervel ) {
  int minindex = -1;
  float mind = Float.MAX_VALUE;

  for ( int i = 0; i < pursuerpos.length; i = i+1 ) {
    float d = dist(pos.x, pos.y, pursuerpos[i].x, pursuerpos[i].y);
    if ( d <= mind ) { 
      mind = d; 
      minindex = i;
    }
  }

  if ( minindex == -1 ) { 
    return new PVector(0, 0);
  } else { 
    return computeEvade(pos, vel, maxspeed, pursuerpos[minindex], pursuervel[minindex]);
  }
}

// compute the evade steering vector - evades the nearest pursuer within the boid's neighborhood
//  pos, vel - position and velocity of boid
//  radius, angle - define this boid's neighborhood
//  maxspeed - boid's max speed
//  pursuerpos, pursuervel - positions and velocities of potential pursuers
PVector computeEvade ( PVector pos, PVector vel, float radius, float angle, float maxspeed, PVector[] pursuerpos, PVector[] pursuervel ) {
  int minindex = -1;
  float mind = Float.MAX_VALUE;

  for ( int i = 0; i < pursuerpos.length; i = i+1 ) {
    if ( isNeighbor(pos, vel, radius, angle, pursuerpos[i]) ) {
      float d = dist(pos.x, pos.y, pursuerpos[i].x, pursuerpos[i].y);
      if ( d <= mind ) { 
        mind = d; 
        minindex = i;
      }
    }
  }

  if ( minindex == -1 ) { 
    return new PVector(0, 0);
  } else { 
    return computeEvade(pos, vel, maxspeed, pursuerpos[minindex], pursuervel[minindex]);
  }
}

// compute the interpose steering vector 
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  targetpos1, targetvel1, targetpos2, targetvel2 - positions and velocities of
//   the boids to move between
PVector computeInterpose ( PVector pos, PVector vel, float maxspeed, PVector targetpos1, PVector targetvel1, PVector targetpos2, PVector targetvel2 ) {
  // determine targets' expected future positions
  PVector curmid = PVector.mult(PVector.add(targetpos1, targetpos2), .5);  // current midpoint
  float t = dist(pos.x, pos.y, curmid.x, curmid.y)/vel.mag();
  PVector future1 = PVector.add(targetpos1, PVector.mult(targetvel1, t));
  PVector future2 = PVector.add(targetpos2, PVector.mult(targetvel2, t));
  // seek midpoint of targets' future positions
  PVector futuremid = PVector.mult(PVector.add(future1, future2), .5);  
  return computeSeek(pos, vel, maxspeed, futuremid);
}

// compute the shadow steering vector 
//  targeting a quarry at position 'quarrypos' with velocity 'quarryvel'
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  quarrypos, quarryvel - position and velocity of quarry
//  threshold - distance from quarry at which boid starts matching velocities
PVector computeShadow (  PVector pos, PVector vel, float maxspeed, PVector quarrypos, PVector quarryvel, float threshold ) {
  // if close, match velocity with quarry, 
  // otherwise arrive at target
  if ( dist(pos.x, pos.y, quarrypos.x, quarrypos.y) <= threshold ) {
    return PVector.sub(quarryvel, vel);
  } else {
    return computeArrive(pos, vel, maxspeed, quarrypos, threshold);
  }
}

// compute the hide steering vector
//  pos, vel - position and velocity of boid
//  maxspeed - boid's max speed
//  seekerpos, seekervel - position and velocity of boid that is being hidden from
//  obspos, obsradius - position and radius of circular obstacle to hide behind
PVector computeHide ( PVector pos, PVector vel, float maxspeed, PVector seekerpos, PVector seekervel, PVector obspos, float obsradius ) {
  // compute opposite point
  PVector oppvec = PVector.sub(obspos, seekerpos);
  oppvec.setMag(obsradius*1.5);
  PVector opposite = PVector.add(obspos, oppvec);
  // arrive at position on opposite side of obstacle from seeker
  return computeArrive(pos, vel, maxspeed, opposite, obsradius);
}


// compute the collision avoidance steering vector (for avoiding other boids)
//  pos, vel - position and velocity of boid
//  maxforce - maximum steering force that can be applied to the void
//  avoidpos, avoidvel - position and velocity of the boid to avoid
PVector computeCollisionAvoidance ( PVector pos, PVector vel, float maxforce, PVector avoidpos, PVector avoidvel ) {
  float t = PVector.dot(PVector.mult(PVector.sub(pos, avoidpos), -1), PVector.sub(vel, avoidvel))/PVector.sub(vel, avoidvel).magSq();
  PVector ourpos = PVector.add(pos, PVector.mult(vel, t));
  PVector otherpos = PVector.add(avoidpos, PVector.mult(avoidvel, t));
  PVector steer = PVector.sub(ourpos, otherpos);
  steer.setMag(maxforce);
  // apply a small braking force
  steer.add(PVector.mult(vel, -.1));
  return steer;
}

// compute the collision avoidance steering vector (for avoiding other boids)
//  pos, vel - position and velocity of boid
//  maxforce - maximum steering force that can be applied to the void
//  avoidpos, avoidvel - position and velocity of the boid to avoid
//  lookahead - how many timesteps into the future to consider
PVector computeCollisionAvoidance ( PVector pos, PVector vel, float maxforce, PVector avoidpos, PVector avoidvel, float lookahead ) {
  PVector[] p = { avoidpos };
  PVector[] v = { avoidvel };
  return computeCollisionAvoidance(pos, vel, maxforce, p, v, lookahead);
}

// compute the collision avoidance steering vector (for avoiding other boids)
//  pos, vel - position and velocity of boid
//  maxforce - maximum steering force that can be applied to the void
//  p, v - positions and velocities of all boids
//  lookahead - how many timesteps into the future to consider 
PVector computeCollisionAvoidance ( PVector pos, PVector vel, float maxforce, PVector[] p, PVector[] v, float lookahead ) {
  PVector forward = new PVector(vel.x, vel.y);
  forward.normalize();

  int minindex = -1;
  float mint = lookahead;

  for ( int j = 0; j < p.length; j = j+1 ) {
    if ( p[j] == pos && v[j] == vel ) { 
      continue;
    }

    // find time of closest point of approach
    float t = PVector.dot(PVector.mult(PVector.sub(pos, p[j]), -1), PVector.sub(vel, v[j]))/PVector.sub(vel, v[j]).magSq();
    if ( t >= 0 && t <= lookahead ) {  
      // closest point of approach is still ahead, but not too far
      float dist = PVector.sub(PVector.add(pos, PVector.mult(vel, t)), PVector.add(p[j], PVector.mult(v[j], t))).mag();
      if ( dist <= 20 ) {   // too close!
        if ( t <= mint ) { 
          mint = t; 
          minindex = j;
        }
      }
    }
  }

  if ( minindex == -1 ) { 
    return new PVector(0, 0);
  } else { 
    return computeCollisionAvoidance(pos, vel, maxforce, p[minindex], v[minindex]);
  }
}


// compute the obstacle avoidance steering vector
//  pos, vel - position and velocity of boid
//  maxforce - maximum steering force that can be applied to the void
//  obspos - position of the obstacle to avoid
PVector computeObsAvoidance ( PVector pos, PVector vel, float maxforce, PVector obspos ) {
  // steer away from the obstacle with max force
  float t = PVector.dot(PVector.sub(obspos, pos), vel)/PVector.dot(vel, vel);
  PVector projection = PVector.add(pos, PVector.mult(vel, t));
  PVector steer = PVector.sub(projection, obspos);
  steer.setMag(maxforce);
  // apply a small braking force
  steer.add(PVector.mult(vel, -.1));
  return steer;
}

// compute the obstacle avoidance steering vector
//  pos, vel - position and velocity of boid
//  maxforce - maximum steering force that can be applied to the void
//  obspos, obsradius - position and radius of the obstacle to avoid
//  lookahead - how many timesteps into the future to consider
PVector computeObsAvoidance ( PVector pos, PVector vel, float maxforce, PVector obspos, float obsradius, float lookahead ) {
  PVector[] p = { obspos };
  float[] r = { obsradius };
  return computeObsAvoidance(pos, vel, maxforce, p, r, lookahead);
}

// compute the obstacle avoidance steering vector
//  pos, vel - position and velocity of boid
//  maxforce - maximum steering force that can be applied to the void
//  obspos, obsradius - positions and radii of all of the obstacles
//  lookahead - how many timesteps into the future to consider 
PVector computeObsAvoidance ( PVector pos, PVector vel, float maxforce, PVector[] obspos, float[] obsradius, float lookahead ) {
  // find closest obstacle in the boid's path
  int minindex = -1;
  float mint = lookahead;
  for ( int i = 0; i < obspos.length; i = i+1 ) {
    float t = PVector.dot(PVector.sub(obspos[i], pos), vel)/PVector.dot(vel, vel);
    if ( t >= 0 && t <= lookahead ) {   // within range ahead of boid
      PVector projection = PVector.add(pos, PVector.mult(vel, t));
      if ( dist(projection.x, projection.y, obspos[i].x, obspos[i].y) <= obsradius[i]+10 ) {
        // obstacle is a threat!
        if ( t <= mint ) { 
          minindex = i;
          mint = t;
        }
      }
    }
  }

  if ( minindex == -1 ) { 
    return new PVector(0, 0);
  } else { 
    return computeObsAvoidance(pos, vel, maxforce, obspos[minindex]);
  }
}


// compute the separation steering vector
// separation pushes the boid away from each of its neighbors
//  pos, vel - position and velocity of boid
//  radius, angle - define this boid's neighborhood
//  p, v - positions and velocities of all boids
PVector computeSeparation ( PVector pos, PVector vel, float radius, float angle, PVector[] p, PVector[] v ) {
  PVector total = new PVector();

  for ( int j = 0; j < p.length; j = j+1 ) {
    if ( pos != p[j] && vel != v[j] && isNeighbor(pos, vel, radius, angle, p[j]) ) {
      PVector repulsion = PVector.sub(pos, p[j]);
      float dist = repulsion.mag();
      repulsion.normalize();
      if ( dist > .001 ) { 
        repulsion.mult(1.0/dist);
      }
      total.add(repulsion);
    }
  }
  return total;
}

// compute the alignment steering vector
// alignment steers the boid towards the average of the neighbors' velocities
//  pos, vel - position and velocity of boid
//  radius, angle - define this boid's neighborhood
//  p, v - positions and velocities of all boids
PVector computeAlignment ( PVector pos, PVector vel, float radius, float angle, PVector[] p, PVector[] v) {  
  PVector total = new PVector();
  int numneighbors = 0;

  for ( int j = 0; j < p.length; j = j+1 ) {
    if ( pos != p[j] && vel != v[j] && isNeighbor(pos, vel, radius, angle, p[j]) ) {
      total.add(v[j]);
      numneighbors = numneighbors+1;
    }
  }
  if ( numneighbors == 0 ) { 
    return total;
  } else {
    PVector average = PVector.div(total, numneighbors);
    return PVector.sub(average, vel);
  }
}

// compute the cohesion steering vector
// cohesion steers the boid towards the center of its neighbors
//  pos, vel - position and velocity of boid
//  radius, angle - define this boid's neighborhood
//  p, v - positions and velocities of all boids
PVector computeCohesion ( PVector pos, PVector vel, float radius, float angle, PVector[] p, PVector[] v) {  
  PVector total = new PVector();
  int numneighbors = 0;

  for ( int j = 0; j < p.length; j = j+1 ) {
    if ( pos != p[j] && vel != v[j] && isNeighbor(pos, vel, radius, angle, p[j]) ) {
      total.add(p[j]);
      numneighbors = numneighbors+1;
    }
  }    
  if ( numneighbors == 0 ) { 
    return total;
  } else {
    PVector average = PVector.div(total, numneighbors);
    return PVector.sub(average, pos);
  }
}
