rails-photo-organizer
==========

A way to organize a massive collection of photos together with your family and friends.

## How does it work?

 * You run this application as a server and point your contributors to it.
 * Each of you then proceeds to check every photo and tag them as you see fit.
 * Later you can easily search for photos by tag and just enjoy them

Scroll down to see some screenshots of it in action...

## How to set it up

 * You have to have Ruby and Rails installed. See [here](http://rvm.io/) for details.
 * Download the source code of this project, go to it's folder using the command line.
 * Run 'bundle install' to install all the project dependencies.
 * Run 'rake db:migrate' to create the database
 * Place all of the desired images inside the './public/images/' folder, a symlink to the a folder where you keep all your images will work well on a Linux or MacOs system.
 * Run the 'rake add_images' command
 * Wait until they all get inserted into the system, this may take several minutes because it will be creating thumbnails, checking for repeated pictures, extracting metadata and stuff.
 * Run the server with 'rails server' or using a Rack setup if you know what you're doing.

## Limitations

This is a simple hack in it's core and simplicity of operation is the key here. Look at photos, tag photos. Nothing more and nothing less. It's not even meant for operation in large scale, just something running on a small server for your family and friends to organize their pictures.

That being said, the CSS is not very good for smaller screen devices, the error handling all around is a little hacky, there are no tests and there is no way to upload new pictures apart from placing them in the image folder.

## Interested? Get in touch

If you're interested in using this system or some variation of it in a production environment
get in touch with me. I'm open to adding new features, making ir customized to new needs and
helping you set up the system on a real server.

## Screenshots

### Photo gallery

![photos](http://dl.dropbox.com/u/2701879/uploads/rails-photo-organizer/photos.png)

### Photo interface and tagging

![tagging](http://dl.dropbox.com/u/2701879/uploads/rails-photo-organizer/photo.png)

### Search by tags

![search](http://dl.dropbox.com/u/2701879/uploads/rails-photo-organizer/category.png)
