class RemoveColumnPasswordDigestFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column(:users, :password_digest, if_exists: true)
  end
end
