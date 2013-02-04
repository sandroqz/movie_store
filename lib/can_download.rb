module CanDownload
  def streamable
    where("user_movies.can_download=?", false)
  end
  def downloadable
    where("user_movies.can_download=?", true)
  end
end
