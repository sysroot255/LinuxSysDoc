haredhome="/home/postproduction/"
movie="awesome_movie_project"

# we'll make a folder to house all the movie data
mkdir -p $sharedhome$movie

# we cd into that directory to make our life easier
cd $sharedhome$movie
echo "we'll create all files here: $(pwd)"

# planning
touch planning.ics
chown marie:planning planning.ics
chmod 664 planning.ics

# scenario
touch scenario.md
chown marie:script scenario.md
chmod 664 scenario.md

# audiofiles
mkdir audiofiles
chown marie:audioengineers audiofiles
chmod 2770 audiofiles
mkdir -p audiofiles/day{01..14}

touch audiofiles/day{01..14}/recording_{00..99}.wav
chown marie:audioengineers -R audiofiles
chmod 2770 audiofiles
chmod 2770 audiofiles/day{01..14}
chmod 0660 audiofiles/day{01..14}/*.wav

# videofiles
mkdir videofiles
chown marie:videoeditors videofiles
chmod 2770 videofiles
mkdir -p videofiles/day{01..14}

touch videofiles/day{01..14}/clip_{00..99}.mp4
chown marie:videoeditors -R videofiles
chmod 2770 videofiles
chmod 2770 videofiles/day{01..14}
chmod 0660 videofiles/day{01..14}/*.mp4

# renders
mkdir -p renders
touch renders/final_render.{wav,mp4}
chmod 664 renders/final_render.{wav,mp4}
chown marie:technical renders
chown marie:audioengineers renders/final_render.wav
chown marie:videoeditors renders/final_render.mp4

