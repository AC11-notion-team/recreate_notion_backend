class Api::V1::SharepagesController < ApplicationController
  def invite_to_others
    page = Page.find(params[:currentPageId])
    add_share_user = []
    params[:inviteUsers]&.map do |user_email|
      user = User.find_by(email: user_email)
      unless page.users.include?(user)
        Sharepage.create!(user_id: user.id, page_id: params[:currentPageId])
        add_share_user << user
        SharepagesMailer.sharepage_link(user,page).deliver_now
      end
    end
    render json: add_share_user
  end

  def remove_invite
    remove_user = User.find_by(email: params[:email])
    if remove_user.present?
      remove_share = Sharepage.find_by(page_id: params[:currentPageId], user_id: remove_user.id)
      remove_share.destroy
    end
  end
end
