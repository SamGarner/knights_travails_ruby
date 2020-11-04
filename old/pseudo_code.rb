# frozen_string_literal: false

# Pseudo 

Knight
-acts as a 'node' with knights coordinates and the parent node (previous knight/coordinates)

Board
-holds board grid

steps
-starting value and ending value input
-starting value = new node/knight with starting coordinates 
                  (set parent coord == start coord for how to identify initial 'root'?)
-'current' coordinates == end goal coordinates?
  -if so, end and output 'no moves needed'
  -if not:
    -get list of next possible moves (instantiated as nodes/knights)
    -check if list of new knights/nodes includes end goal coordinates
      -if not, repeat/recurse
      -if yes, 'count'/print the parent nodes/knights all the way up the chain --> recursive output?
