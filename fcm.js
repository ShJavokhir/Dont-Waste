

curl -X POST -H "Authorization: Bearer dZc4RNlXSDeS02OgKMEjGX:APA91bGqagXnXoBDilhafMXn2_w1w1orymFmOZzLduhTUFjCIIWhvyD2Un5NJSEJqHG_sl0B2xg4_ZA8LXqLeC5Q_YwelTN_c_JAs2NiQcl_Ez63l9WpPLru3lwrTTgQsdeWZX2pU1bj" -H "Content-Type: application/json" -d '{
  "message":{
    "token":"dZc4RNlXSDeS02OgKMEjGX:APA91bGqagXnXoBDilhafMXn2_w1w1orymFmOZzLduhTUFjCIIWhvyD2Un5NJSEJqHG_sl0B2xg4_ZA8LXqLeC5Q_YwelTN_c_JAs2NiQcl_Ez63l9WpPLru3lwrTTgQsdeWZX2pU1bj",
    "notification":{
      "title":"Hello",
      "body":"This is a text message!"
    }
  }
}' https://fcm.googleapis.com/v1/projects/food-waste-uz/messages:send