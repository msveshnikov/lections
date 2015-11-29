class AddIpToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :ip, :string
  end
end
