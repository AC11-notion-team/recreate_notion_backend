class DeleteUserRefFromPage < ActiveRecord::Migration[6.1]
  def change
    remove_reference :pages, :user, index: true
  end
end
