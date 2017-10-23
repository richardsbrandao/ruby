class CreateJoinTableCdTrack < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cds, :tracks do |t|
      t.index [:cd_id, :track_id]
      t.index [:track_id, :cd_id]
    end
  end
end
