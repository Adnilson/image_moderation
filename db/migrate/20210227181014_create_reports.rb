class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.bigint :user_id
      t.boolean :moderated, default: false
      t.boolean :evaluated, default: false
      t.decimal :graphic_score
      t.string :caller_url

      t.timestamps
    end
  end
end
