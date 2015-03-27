module TagsHelper
  def create_or_assign_tags
    tag_names.each do |tag_name|
      tag = Tag.find_by_name(tag_name)

      if tag.nil?
        @taggable.tags.create(name: tag_name)
      else
        @taggable.tag_assignments.create(tag_id: tag.id)
      end
    end
  end

  def tag_names
    if tag_params[:tag_names].blank?
      []
    else
      tag_params[:tag_names].split(' ')
    end
  end
end