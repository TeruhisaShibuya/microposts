class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.references :user, index: true, foreign_key: true  #index:tuue 指定ユーザを高速読み込み user idに対してインデックスを作成カラムに追加
      t.text :content

      t.timestamps null: false
      t.index [:user_id, :created_at]  #複合インデックス マイクロポストの読み込みを早く 作成順に表示
    end
  end
end

