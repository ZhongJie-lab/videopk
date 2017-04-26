if @battle.present?
  json.extract! @battle, :id, :title, :description, :left_video_id, :right_video_id
else
  return "no battle"
end