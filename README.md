### Setup ###

###### On OSC ######
```bash
cd ~/awesim_dev/
git clone git@bitbucket.org:megazear7/container-sim
mv container-sim rails1 # or rails[1-10]
cd rails1
rake db:schema:load
rake app:create
```
* Then  go to https://apps.awesim.org/devapps/ and restart Apache.
* Next go to https://websvcs02.osc.edu/awesim_dev/rails1/simapp/#/admin and create the app.
* Finally, go to https://websvcs02.osc.edu/awesim_dev/rails1/simapp/#/ and use the app.

### JavaScript Overview ###

I wanted to give a quick overview of the javascript file layout as well as what the different portions of javascript and html represent.

File Layout:

/app.coffee
> This is the website - wide angular application. It does configuration and is responsible for defining the client side Angular routes, as well as what controller handles the route and the template that is used.

/controllers
> These are all angular controllers, and they come in the following two forms

/controllers/layouts
> These are top level Angular controllers that are responsible for loading the needed modules into the page and visually organizing the modules on the page. These controllers also have access to the url information. There is only one of these types of modules on any given page.

/controllers/modules
> These are Angular controllers that get imbeded into a layout controller. These controllers can be loaded on any page (unless it has heavy assumptions about data that it expects from parent controllers). However these controllers cannot use any url information. If they want url informaton they must get it from there parent layout controller.

/templates/layouts
> These are template html files that app.coffee references in loading pages when the url changes and assigning a controller and layout to govern a specific page.

/templates/modules
> These are template html files that module controllers reference as the html that is supposed to go along with a given module. By convention a module controller should have a $scope.template.url param with the value of '/modules/<my_module>.html' which layout controllers (or other module controllers) will use to plug a module into the page using ng-include.

/models
> These are the javascript modules. This is basicly the data format as seen on the front end. The are factories that are injected into the controllers. The format of the interface is similiar to active record. So a controller can do things like "Project.create({...})" and does not have to worry about saving it to the database. The model factories abstract this away.

/factories
> These are general purpose factories. The only one we have so far is DataCache. The DataCache is just a dump of data is shared across the app. The model factories interact with this data. It basically serves as local storage of the data. Whatever data that a controller needs here will be declared by a controller (or maybe model?) and then if other data is needed it will be loaded as it is needed.
/application.js
> This is the standard rails asset pipeline stuff. Leave it as is.