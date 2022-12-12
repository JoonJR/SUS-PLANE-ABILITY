const map = L.map('map', {tap: false});
L.tileLayer('https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}', {
  
  maxZoom: 20,
  subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
}).addTo(map);
map.setView([60, 24], 7);

// global variables
const apiUrl = 'http://127.0.0.1:5000/';
const startLoc = 'EFHK';
const globalGoals = [];
const airportMarkers = L.featureGroup().addTo(map);

// icons
const blueIcon = L.divIcon({className: 'blue-icon'})
const greenIcon = L.divIcon({className: 'green-icon'})

//timer
  function timer(){
  document.getElementById('timer').innerHTML = 03 + ":" + 00;
  startTimer();
  function startTimer() {
    var presentTime = document.getElementById('timer').innerHTML;
    var timeArray = presentTime.split(/[:]+/);
    var m = timeArray[0];
    var s = checkSecond((timeArray[1] - 1));
    if(s==59){m=m-1}
    if(m<0){
      return
    }
    if (m ==0 && s ==5){ 
      document.getElementById('timer').style.color = "#ff2a6ea0";
    }
    if (m ==0 && s ==0){ //time runs out
      document.getElementById("custom-alert").style.display ="none";
      document.getElementById("map").style.filter = "hue-rotate(200deg)"
      setTimeout(function() { // message will appear after 2 sec 
        document.getElementById("death").style.display = "flex";
        document.getElementById("death-text").innerHTML = "Times out! You didn't save the Earth in time."
        document.getElementById("oki").addEventListener("click", function() {
        window.location.reload();
    });
      },2)
    }
    document.getElementById('timer').innerHTML = m + ":" + s;
    setTimeout(startTimer, 1000);
  }
  function checkSecond(sec) {
    if (sec < 10 && sec >= 0) {sec = "0" + sec}; 
    if (sec < 0) {sec = "59"};
    return sec;
  }
  }

//start the game/form
document.querySelector("#start").addEventListener("click", function() {
document.getElementById("player-modal").style.display = "flex"});
document.querySelector('#player-form').addEventListener('submit', function (evt) {
  evt.preventDefault();
  const playerName = document.querySelector('#player-input').value;
  document.getElementById("player-modal").style.display = "none"

  timer(); //starts the timer when the name is entered
  gameSetup(`${apiUrl}newgame?player=${playerName}&loc=${startLoc}`);
});

// function to fetch data from API
async function getData(url){
  const response = await fetch(url);
  if (!response.ok) throw new Error('Invalid server input.');
    const data = await response.json();
    console.log(data);
    return data;
}
// function to update game status
function updateStatus(status) {
  document.querySelector('#player-name').innerHTML = `${status.name}`;
  document.querySelector('#consumed').innerHTML = `${status.co2.consumed}`;
  document.querySelector('#countries').innerHTML = `${status.collected_countries}`
  document.querySelector('#dice').innerHTML = `${status.dice}`;

 
  if (status.dice === 1) {
    let chance =(Math.floor(Math.random() * 2) + 1); //increases chances of surviving
    if (chance === 1){
      document.getElementById("death").style.display = "flex";
      checkGameOverDice(chance);
      
    }
    else {
      // status.dice != 1;
      document.getElementById("death").style.display = "none";
      document.getElementById("custom-alert").style.display = "flex";
      document.getElementById('custom-alert-title').innerHTML = "Dice 1";
      document.getElementById('custom-alert-text').innerHTML = "You nearly died.";
      document.getElementById("oks").addEventListener("click", function() {
      document.getElementById("custom-alert").style.display = "none";
    });
    }
  }

  if (status.dice === 2) {
    document.getElementById('custom-alert-title').innerHTML = "Dice 2";
    document.getElementById('custom-alert-text').innerHTML = "You had to take an unexpected detour. Double the amount of Co2 consumed.";
    document.getElementById("custom-alert").style.display = "flex";
    document.getElementById("oks").addEventListener("click", function() {
      document.getElementById("custom-alert").style.display = "none";
    });
  }
  if (status.dice === 3) {
    document.getElementById('custom-alert-title').innerHTML = "Dice3";
    document.getElementById('custom-alert-text').innerHTML = "Your planes GPS breaks and you ended up somewhere else.";
    document.getElementById("custom-alert").style.display = "flex";
    document.getElementById("oks").addEventListener("click", function() {
      document.getElementById("custom-alert").style.display = "none";
    });
  }
  if (status.dice === 4) {
    document.getElementById('custom-alert-title').innerHTML = "Dice 4";
    document.getElementById('custom-alert-text').innerHTML = "Your plane had to return to the previous airport. Full amount of Co2 wasted for that trip.";
    document.getElementById("custom-alert").style.display = "flex";
    document.getElementById("oks").addEventListener("click", function() {
      document.getElementById("custom-alert").style.display = "none";
    });

  }
  if (status.dice === 5) {
    document.getElementById('custom-alert-title').innerHTML = "Dice 5";
    document.getElementById('custom-alert-text').innerHTML = "You got a 50% Co2 refund for this flight.";
    document.getElementById("custom-alert").style.display = "flex";
    document.getElementById("oks").addEventListener("click", function() {
      document.getElementById("custom-alert").style.display = "none";
    });
  }
  if (status.dice === 6) {
    document.getElementById('custom-alert-title').innerHTML = "Dice 6";
    document.getElementById('custom-alert-text').innerHTML = "You got a full Co2 refund for this flight.";
    document.getElementById("custom-alert").style.display = "flex";
    document.getElementById("oks").addEventListener("click", function() {
      document.getElementById("custom-alert").style.display = "none";
    });
  }
  console.log(status.dice);
}
// function to show weather at selected airport
function showWeather(airport) {
  document.querySelector('#airport-temp').innerHTML = `${airport.weather.temp}°C`;
  document.querySelector('#weather-icon').src = airport.weather.icon;
}
// function to show countries info
function showCountriesData(airport){
  document.querySelector('#current-country').innerHTML = `${airport.country_data.country}`;
  document.querySelector('#population').innerHTML = `${airport.country_data.population}`;
  document.querySelector('#language').innerHTML = `${airport.country_data.language}`;
  document.querySelector('#currency').innerHTML = `${airport.country_data.currency}`;
  document.querySelector('#capital').innerHTML = `${airport.country_data.capital}`;
  document.querySelector('#flag').src = airport.country_data.flag;

}

// functions to check if the player went over the budget
function checkGameOver(budget) {
  if (budget <= 0) {
  console.log(budget);
  document.getElementById("custom-alert").style.display ="none";
  document.getElementById("map").style.filter = "hue-rotate(200deg)";
  setTimeout(function() { // message will appear after 2 sec 
    document.getElementById("death").style.display = "flex";
    document.getElementById("death-title").innerHTML = 'GAME OVER';
    document.getElementById("death-text").innerHTML = "You went over the budget and caused even worse pollution. Good job!.";
    document.getElementById("oki").addEventListener("click", function() {
    window.location.reload(); 
  });
  },2)
    return false;
  }
  return true;
}
// functions to check if the death dice was rolled
function checkGameOverDice(dice) {
  if (dice === 1) {
        document.getElementById("death-text").innerHTML = "Dice 1. Your plane crashed. Unlucky."
        document.getElementById("oki").addEventListener("click", function() {
      window.location.reload(); });
    return false;
  }
  return true;
}
// function to check the amount of countries collected
function checkCountries(countries) {
    if (countries === 10){
      document.getElementById("map").style.filter = "hue-rotate(96deg)"
      document.querySelector('#purification').innerHTML = "20%"
    }
    if (countries === 20){
      document.getElementById("map").style.filter = "hue-rotate(72deg)"
      document.querySelector('#purification').innerHTML = "40%"
    }
    if (countries === 30){
      document.getElementById("map").style.filter = "hue-rotate(48deg)"
      document.querySelector('#purification').innerHTML = "60%"
    }
    if (countries === 40){
      document.getElementById("map").style.filter = "hue-rotate(24deg)"
      document.querySelector('#purification').innerHTML = "80%"
    }
    if (countries === 50){
      document.getElementById("map").style.filter = "hue-rotate(0deg)"
      document.querySelector('#purification').innerHTML = "Purification: " + 100 + "%"
    }
  
  if (countries === 50) {
    document.getElementById("custom-alert").style.display = "none";
    document.getElementById("win").style.display = "flex";
        document.getElementById("win-text").innerHTML = "You did it! You saved the Earth!."
        document.getElementById("okay").addEventListener("click", function() {
          console.log('click');
          window.location.reload() });
    return false;
  }
  return true;
}

// this is the main function that creates the game and calls the other functions
async function gameSetup(url){
  try {
    const gameData = await getData(url);
    updateStatus(gameData.status);
      if (!checkGameOver(gameData.status.co2.budget)) return;
      if (!checkGameOverDice(gameData.status.dice)) return;
      if (!checkCountries(gameData.status.collected_countries)) return;
      
      for(let airport of gameData.location){
      const marker = L.marker([airport.latitude, airport.longitude]).addTo(map);
      if(airport.active){
        showWeather(airport);
        showCountriesData(airport)
        marker.bindPopup(`You are here: <b>${airport.name}</b>`);
        marker.openPopup();
        marker.setIcon(greenIcon);
      }
      else {
        marker.setIcon(blueIcon);
        const popupContent = document.createElement('div');
        const h4 = document.createElement('h4');
        h4.innerHTML = airport.name;
        popupContent.append(h4);
        const goButton = document.createElement('button');
        goButton.classList.add('button');
        goButton.innerHTML = 'Fly here';
        popupContent.append(goButton);
        const p = document.createElement('p');
        p.innerHTML = `Distance ${airport.distance} km`;
        popupContent.append(p);
        marker.bindPopup(popupContent);
        goButton.addEventListener('click', function () {
          gameSetup(`${apiUrl}flyto?game=${gameData.status.id}&dest=${airport.ident}&consumption=${airport.co2_consumption}`);
        });
      }
    }
  } catch (error){
    console.log(error);
  }
}

//end game
document.getElementById('stop').addEventListener("click", function() {
  window.location.reload();})