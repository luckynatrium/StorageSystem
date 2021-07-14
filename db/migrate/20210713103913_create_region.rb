class CreateRegion < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE region_enum as ENUM ('central', 'north-west', 'south', 'north-caucasus', 'volga', 'ural','siberia', 'far eastern');
      ALTER TABLE storages ADD region region_enum;
    SQL
        
  end

  def down
    remove_column :storages, :region
    execute <<-SQL
      DROP TYPE region_enum;
    SQL
  end
end
