module ApplicationHelper

  def getfavs
    s = cookies[:fav]
    s = '' if s.blank?
    s.split(',')
  end

  def getfav(id)
    if getfavs.include? id.to_s
      return 'heart-on.jpg'
    else
      return 'heart-off.jpg'
    end
  end

end
