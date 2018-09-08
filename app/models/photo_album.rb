class PhotoAlbum
  def initialize(info)
    @photos = organize_photos(info)
  end

  def make_photos(info)
    info[:media][:photos][:photo].map do |photo_info|
      Photo.new(photo_info)
    end
  end

  def organize_photos(info)
    make_photos(info).inject({}) do |collector, photo|
      collector[photo.id][photo.width] = photo if collector[photo.id]
      collector[photo.id] = {photo.width => photo} unless collector[photo.id]
      collector
    end
  end

  def thumbnail_photo
    @photos[1][300].url if @photos[1][300]
  end

end