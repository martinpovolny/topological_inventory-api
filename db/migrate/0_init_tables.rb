=begin
Topological Inventory

Topological Inventory

OpenAPI spec version: 0.0.1
Contact: you@your-company.com
Generated by: https://github.com/swagger-api/swagger-codegen.git

=end

class InitTables < ActiveRecord::Migration
  def change
    create_table "provider".pluralize.to_sym, id: false do |t|
      t.string :id
      t.string :name
      t.string :description
      t.string :url
      t.string :user
      t.string :password
      t.string :token
      t.boolean :verify_ssl

      t.timestamps
    end

  end
end
