#!/usr/bin/env python

import random
import pyglet
from pyglet import shapes
from pyglet.window import key

import svgwrite

from itertools import accumulate

dwg = svgwrite.Drawing(filename='sample_maze.svg', debug=True)


recording = True
record = []
grid_size_x = 12 *2  
grid_size_y = 18 *2 
block_size=30
movement = {'d': [0,1], 'u': [0,-1], 'l': [-1,0], 'r': [1,0] }
key_move = {key.W: 'u', key.A: 'l', key.S: 'd', key.D: 'r'}
inv_dir = {'d': 'u', 'u': 'd', 'r': 'l', 'l': 'r' }
path = [[0,0]]
_cx=0
_cy=0
maze = [ [] for x in range(0, (grid_size_x * grid_size_y)) ]
mypath = [ False for x in range(0, (grid_size_x * grid_size_y)) ]
clamp = lambda n, minn, maxn: max(min(maxn, n), minn)
marker=True  # show where you are

window = pyglet.window.Window( grid_size_x * block_size, grid_size_y * block_size)
batch = pyglet.graphics.Batch()
maze_gfx = []

height = window.height
width = window.width

# Set default projection to use upper left as origin
pyglet.gl.glMatrixMode(pyglet.gl.GL_PROJECTION)
pyglet.gl.glLoadIdentity()
pyglet.gl.glOrtho(0.0, 1024.0, 768.0, 0.0, -1.0, 1.0)
pyglet.gl.glMatrixMode(pyglet.gl.GL_MODELVIEW)
pyglet.gl.glLoadIdentity()

def path_import(dirs):
    global path

    for d in dirs:
       path_move(path, d, True)

def path_export():
    global record
    print(record)
    create_svg()     

def neighbors(x,y):
    global maze
    n = []
    for _dir in ['u','d','l','r']:
        npt = [  clamp(x + movement[_dir][0], 0, grid_size_x-1   ), clamp(y + movement[_dir][1] , 0, grid_size_y-1) ]
        idx = npt[0] + (npt[1] * grid_size_x)
        if len(maze[idx]) == 0  and npt not in n and not npt == [x,y]:
            n.append([npt,_dir])
    return n
   
def solve(maze,path):
    global marker

    marker=False
    while len(path) > 0:
        [x,y] = path[-1]
        n = neighbors(x,y)

        if n:
            _p = random.choice(n)
            #_p = n[0]
            path = path_move(path, _p[1])
            #path = path_move(path, n[0][1])
        else:
            path.pop()

@window.event
def on_key_press(symbol, modifiers):
    global path,maze

    if symbol in key_move:
        path = path_move( path, key_move[symbol], True)
    if symbol == key.P:
        solve(maze,path)
    if symbol == key.E:
        path_export()
    if symbol == key.I:
        path_import(['d', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'r', 'r', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'u', 'r', 'r', 'd', 'd', 'd', 'd', 'r', 'r', 'u', 'u', 'u', 'u', 'r', 'r', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'd', 'r', 'u', 'u', 'u', 'u', 'u', 'u', 'r', 'r', 'd', 'd', 'l', 'r', 'd', 'd', 'd', 'd', 'u', 'u', 'u', 'u', 'u', 'd', 'l', 'l', 'r', 'r', 'u', 'u', 'u', 'u', 'u', 'r', 'r', 'r', 'r', 'r', 'd', 'd', 'l', 'd', 'l', 'd', 'l', 'd', 'l', 'd', 'd', 'd', 'd', 'r', 'r', 'r', 'r', 'u', 'u', 'u', 'u', 'u', 'r', 'r', 'l', 'l', 'd', 'd', 'r', 'l', 'd', 'd', 'd', 'r', 'r', 'r'])
    create_maze()

def path_move(path, _dir, mark=False):
    global maze,_cx,_cy

    if recording:
        record.append(_dir)

    # get the current location we are at
    [cx,cy] = path[-1]

    # get the new x,y
    [nx,ny] = [  clamp(cx + movement[_dir][0], 0, grid_size_x-1   ), clamp(cy + movement[_dir][1] , 0, grid_size_y-1) ]

    _cx = nx
    _cy = ny

    # index in maze array
    idx = cx + (cy * grid_size_x)

    # the other side of the wall
    idx2 = nx + (ny * grid_size_x)

    # knock out the walls
    if not _dir in maze[idx]:
        maze[idx].append(_dir)
    if not inv_dir[_dir] in maze[idx2]:
        maze[idx2].append(inv_dir[_dir])

    if mark:
        mypath[idx] = True
        mypath[idx2] = True

    # push the new location onto path
    path.append( [nx,ny] )

    return path


@window.event
def on_draw():
    window.clear()
    batch.draw()

def create_maze():
    global maze_gfx,path,cx,cy,marker

    maze_gfx = []
    lw  =15 

    for x in range(0, grid_size_x):
        for y in range(0, grid_size_y):
            idx = x + y * grid_size_x

            _x = (x* block_size)
            _y = height-(y* block_size)

            if  mypath[idx]:
                maze_gfx.append( 
                        shapes.Rectangle(_x,_y, block_size, block_size, color=(25,25,255), batch=batch)
                        )

            if not 'd' in maze[idx]:
                maze_gfx.append(
                        shapes.Line(_x - lw/2 , _y , _x + block_size + lw/2, _y, width=lw, color=(255,255,255), batch=batch )
                        )
            if not 'u' in maze[idx]:
                maze_gfx.append(
                        shapes.Line(_x - lw/2, _y + block_size , _x + block_size + lw/2, _y + block_size, width=lw, color=(255,255,255), batch=batch )
                        )
            if not 'r' in maze[idx]:
                maze_gfx.append(
                        shapes.Line(_x  + block_size, _y , _x + block_size , _y + block_size , width=lw, color=(255,255,255), batch=batch )
                        )
            if not 'l' in maze[idx]:
                maze_gfx.append(
                        shapes.Line(_x  , _y , _x , _y + block_size , width=lw, color=(255,255,255), batch=batch )
                        )
    if marker:
        maze_gfx.append( shapes.Rectangle( _cx*block_size , height-(_cy * block_size) , block_size, block_size, color=(255,0,0), batch=batch) )


def create_svg():
    global maze

    lw  = block_size - 10
    fill_color="black"

    shapes = dwg.add(dwg.g(id='shapes', fill=fill_color))
    final_path = dwg.add(dwg.g(id='final_path', fill='red'))

    for x in range(0, grid_size_x):
        for y in range(0, grid_size_y):
            idx = x + y * grid_size_x

            # assume these points are the center points
            _x = (x* block_size)
            _y = (y* block_size)

            if 'd' in maze[idx]:
                shapes.add( dwg.rect( insert=(_x - (lw/2), _y - (lw/2)), size=(lw, (block_size/2) + (lw/2))))
                if mypath[idx]:
                    final_path.add( dwg.rect( insert=(_x - (lw/2), _y - (lw/2)), size=(lw, (block_size/2) + (lw/2))))
            if 'u' in maze[idx]:
                shapes.add( dwg.rect( insert=(_x - (lw/2), _y - (block_size/2)), size=(lw, (block_size/2) + (lw/2))))
                if mypath[idx]:
                    final_path.add( dwg.rect( insert=(_x - (lw/2), _y - (block_size/2)), size=(lw, (block_size/2) + (lw/2))))
            if 'r' in maze[idx]:
                shapes.add( dwg.rect( insert=(_x  - (lw/2), _y - (lw/2) ), size=( (block_size/2) + (lw/2), lw)))
                if mypath[idx]:
                    final_path.add( dwg.rect( insert=(_x  - (lw/2), _y - (lw/2) ), size=( (block_size/2) + (lw/2), lw)))
            if 'l' in maze[idx]:
                shapes.add( dwg.rect( insert=(_x  - (block_size/2),  _y - (lw/2) ), size=( (block_size/2) + (lw/2), lw)))
                if mypath[idx]:
                    final_path.add( dwg.rect( insert=(_x  - (block_size/2),  _y - (lw/2) ), size=( (block_size/2) + (lw/2), lw)))

                
    dwg.save()

create_maze()
pyglet.app.run()
