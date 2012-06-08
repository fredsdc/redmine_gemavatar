class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.column :user_id, :integer, :null => false
      t.column :location, :string, :null => false
      t.column :created, :date, :null => false
    end
    execute <<-SQL
        ALTER TABLE pictures
        ADD CONSTRAINT fk_user_id
        FOREIGN KEY (user_id)
        REFERENCES users(id)
    SQL
  end

  def self.down
    drop_table :pictures
    execute <<-SQL
        DROP FOREIGN KEY fk_user_id
    SQL
  end
end
