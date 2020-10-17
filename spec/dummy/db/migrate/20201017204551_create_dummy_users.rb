# frozen_string_literal: true

class CreateDummyUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :dummy_users do |t|
      t.string :name
      t.string :password_digest

      t.timestamps
    end
  end
end
