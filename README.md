# Community Energy Awareness Dashboard


## Heroku

### Notes

No additional credentials need to be created, the default credentials are accessed through environment variables.

### Running on Heroku

1. Migrate with `heroku run rails db:migrate`
2. Seed the data with `heroku run rails db:seed` to initialize values
3. Run the application with `heroku run rails server`
4. Open a new tab and run `heroku run ruby db/mqttToDatabase.rb`
5. Navigate in a web browser to `https://community-energy-awareness.herokuapp.com/`

### Pushing to Heroku

- `git push heroku <branchname>:main`
- `git push heroku main` if pushing main branch

## Contributors

This project was requested by [The Alaska Center for Energy and Power](https://acep.uaf.edu) and submitted as the senior capstone project of its developers:
[Keegan Palmieri](https://github.com/fkpalmieri),
[Millard Arnold V](https://github.com/imthegngrbrdmn),
[William Fisher](https://github.com/willis240), and
[Blake Caldwell](https://github.com/AlaskaBlake).  

## Usability Testing

### Summary

Two rounds of usability testing were done, in the first round, users were seated in a room with one of the developers as a guide and a few questions were asked. 
In the second round, users were found in a public area and were asked a few shorter questions. 
We found the second approach to be more useful because it was easier to find a variety of users and get a larger sample for testing.

### Documents

Documents for the user testing can be found at:  
- [Round one](https://docs.google.com/document/d/1IjwkGfpJFuuxrjMxiqrntTCFDunrHdIoWV2r9a3TOEc/edit?usp=sharing)
- [Round two](https://docs.google.com/document/d/1jXWgM-x3liAdJHPXROjwuCtoEXi4jAzzFc-m_4uZj2k/edit?usp=sharing)

## Resources:

### Developer Notes

Notes taken by the developers during their process can all be found in the `Notes` folder.

### Rails

- [Jetbrain Rails Intro](https://www.jetbrains.com/help/ruby/create-and-run-your-first-project.html#create_controller_view) 
- [DHH Rails 7 Intro](https://www.youtube.com/watch?v=mpWFrUwAN88)

### Heroku

- [Getting Started with Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails7)
- [Environment Variables](https://devcenter.heroku.com/articles/config-vars)


## License

This project is licensed under the MIT License, a choice made for simplicity and function. In short, anyone is welcome to use the code from this repository however they'd like.
