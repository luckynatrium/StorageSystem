class Storage < ApplicationRecord
   enum region: {
    central: "central",
    north_west: "north-west",
    south: "south",
    north_caucasus: "north-caucasus",
    volga: "volga",
    ural: "ural",
    siberia: "siberia",
    far_eastern: "far eastern",
  }
end
