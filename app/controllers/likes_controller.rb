class LikesController < ApplicationController
  # POST /likes
  def create
    like = Like.new(like_params)

    if like.user_id.blank?
      return redirect_back fallback_location: posts_url, alert: "Select a user to like."
    end

    begin
      like.save!
      redirect_back fallback_location: posts_url, notice: "Liked."
    rescue ActiveRecord::RecordNotUnique
      redirect_back fallback_location: posts_url, alert: "Already liked."
    rescue ActiveRecord::RecordInvalid
      redirect_back fallback_location: posts_url, alert: like.errors.full_messages.to_sentence
    end
  end

  # DELETE /likes/:id
  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_back fallback_location: posts_url, notice: "Unliked."
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
