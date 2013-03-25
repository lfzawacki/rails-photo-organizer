def get_extension filename
    filename.split('.')[-1]
end

def is_image? filename
    ["jpg","png","jpeg","gif"].include? get_extension(filename).downcase
end

def add_image_directory
    cur = Dir.pwd
    Dir.chdir('./public/images')
    images = Dir.glob("**{,/*/**}/*")
    Dir.chdir(cur)

    images.each do |img|
        if is_image? img
            suc = Image.create :filename => img
            puts img
        end
    end
    puts "Finished adding #{images.size} images"
end