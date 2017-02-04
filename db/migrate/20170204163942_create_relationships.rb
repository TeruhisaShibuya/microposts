class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false

      t.index [:follower_id, :followed_id], unique: true 
    end
  end
end


#フォローIDとアンフォローIDの組み合わせのrelationshipモデルの値は同じ物があってはならない unique
#同じのがあったりすると削除が大変