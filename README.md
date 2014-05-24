#### Version (rbenv)

```
ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-darwin13.0.0]
```

### Rakes

```
rake db:schema:load
```

### Erb

```
<%= image_tag("about_slide1.jpg") %>
# Looks assets/images/about_slide1.jpg
```

```
<%= render :partial =>'layouts/side'%>
```

Centering a Div
```
<div class="col-md-5 col-md-offset-3">
```

No turbolinks

```
<%= link_to "Edit THIS Profile id #{@current_user.profile.id}", edit_profile_path(:id => current_user.profile.id), "data-no-turbolink" => true %>
```

#### Selectize

```
<select id="select-movie" name="movie" value="Other" class="selectized"/>
```

name: movie is the column name in db
value:Other is the default value shown or the value taken from DB that user set last time

Use Input if there are maxItems and create:true

```
<input id="select-movie" name="movie" value="Other" class="selectized">
```

#### Flexslider

flexslider.js LINE 822 Change the following manually, for some reason options doesn't work when try to set with window load

```
    slideshow: false,
```


#### AJAX

```
<%= form_tag({:action=>'modify_family', :controller => "blah"},{:remote => true, :class=>"smart-form"}) do %>
```

Works even with turbolinks



#### Avatar


```
 @images = current_user.images.all
 <%= image_tag image.avatar.url(:thumb) %>
```




#### Paths

```

                  <%= link_to "Show", profile_path(:id =>current_user.profile.id), "data-no-turbolink" => true  %>
                </li>
                <li>
                  <%= link_to "Edit", edit_profile_path(:id =>current_user.profile.id), "data-no-turbolink" => true %>

```

#### Ruby

```
 Hash.new {|h, k| h[k] = [] }
```


#### Irb

Create Random User
```
for i in (1..100)
  u = User.new(:username => "#{i}@gmail.com", :password=>"12345678910", :devotion=>"Hindu", :sex=>"Female", :name=>"kevin", :dob=>"01/09/1985")
  u.save
 end
```

### app/assets/stylesheets/bootstrap.css

Edits done here

```
.carousel-indicators li {
  visibility: hidden;
```

# Deploy


#### Faye

```
rackup private_pub.ru -s thin -E production
```

#### SOlr

```
remove the dir solr/
rake sunspot:solr:start
rake sunspot:solr:start RAILS_ENV=production
rake sunspot:reindex
```

#### Rakes

```
RAILS_ENV=production bundle exec rake assets:precompile
```

#### thin

```
RAILS_ENV=production bundle exec rackup private_pub.ru -s thin -E production
```


#### Running it

```
rails server -e production -p 80
```