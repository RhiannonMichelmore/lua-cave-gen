function love.load()
  --creates global "map" (eventually will be the equivalent of 2D array)
  Cave.map = {}
  --runs function to populate map so it is your desired size and sets up alive/dead cells
  initialise(Cave.mapwidth,Cave.mapheight)

  --repeats the simulation step 4 times (what I find optimal, can be changed to more or less)
  for s=1,4 do
    simstep()
  end

  --make the left most and right most columns into walls (so player can't leave map, could make bottom and top walls too if wanted)
  for t=1,#Cave.map do
    Cave.map[t][1].tiletype = 1
    Cave.map[t][#Cave.map[1]].tiletype = 1
  end

  --testing flood
  while floodfill() == false do
    connect()
  end

  --just prints an ascii representation of finished map to terminal
  for a=1,Cave.mapheight do
    for b=1,Cave.mapwidth do
      if Cave.map[a][b].tiletype == 1 then
        io.write("X")
				tilenumber = math.random(6)
				tilestring = 'tile-earth' .. tilenumber
				image = love.graphics.newImage('assets/' .. tilestring .. '.png')
				Cave.map[a][b].image = image
      elseif Cave.map[a][b].tiletype == 2 then
        io.write(" ")
      elseif Cave.map[a][b].tiletype == 3 then
        io.write(".")
      elseif Cave.map[a][b].tiletype == 4 then
        io.write(".")
      else
        io.write(" ")
      end
    end
    print()
  end
end
