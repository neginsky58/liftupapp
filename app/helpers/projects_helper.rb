module ProjectsHelper
	def youtube_embed(youtube_url)
		if youtube_url[/youtu\.be\/([^\?]*)/]
			youtube_id = $1
			%Q{<iframe title="YouTube video player" src="http://www.youtube.com/embed/#{ youtube_id }?rel=0;3&amp;autohide=1&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>}
		elsif youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
			# Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367  
			youtube_id = $5 
			%Q{<iframe title="YouTube video player" src="http://www.youtube.com/embed/#{ youtube_id }?rel=0;3&amp;autohide=1&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>}
		  else
			vimeo_embed(youtube_url)
		end
	end

	def vimeo_embed(vimeo_url)
		vimeo_url[/vimeo\.com\/([^\?]*)/]
		vimeo_id = $1
		%Q{<iframe src="http://player.vimeo.com/video/#{ vimeo_id }?title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;color=ff9933" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>}
	end

end

# width="640" height="390"

# vimeo
# width="640" height="360"
# width="1168" height="656"

	  # %Q{<iframe title="YouTube video player" width="765" height="465" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}


# youtube
# width="765" height="430"
# width="1168" height="657"