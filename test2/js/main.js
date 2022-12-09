// 'use strict';
/* 1. show map using Leaflet library. (L comes from the Leaflet library) */

const map = L.map('map', {tap: false});
L.tileLayer('https://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}', {
  
  maxZoom: 20,
  subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
}).addTo(map);
map.setView([60, 24], 7);

// var Thunderforest_TransportDark = L.tileLayer('https://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png?apikey={apikey}', {
// 	attribution: '&copy; <a href="http://www.thunderforest.com/">Thunderforest</a>, &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
// 	apikey: '<your apikey>',
// 	maxZoom: 22
// });

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
    if (m ==0 && s ==0){
      document.getElementById("map").style.filter = "hue-rotate(200deg)"
      setTimeout(function() { // message will appear after 2 sec 
        alert("Times out! You couldn't save the earth in time..");
        window.location.reload();
      },2)
    }
    document.getElementById('timer').innerHTML = m + ":" + s;
    setTimeout(startTimer, 1000);
  }
  function checkSecond(sec) {
    if (sec < 10 && sec >= 0) {sec = "0" + sec}; // add zero in front of numbers < 10
    if (sec < 0) {sec = "59"};
    return sec;
  }
  }

//form for player name
document.querySelector('#player-form').addEventListener('submit', function (evt) {
  evt.preventDefault();
  const playerName = document.querySelector('#player-input').value;
  document.querySelector('#player-modal').classList.add('hide');
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
  document.querySelector('#player-name').innerHTML = `Player: ${status.name}`;
  document.querySelector('#consumed').innerHTML = `CO2: ${status.co2.consumed}/10000`;
  document.querySelector('#countries').innerHTML = `Countries: ${status.collected_countries}/50`
  document.querySelector('#dice').innerHTML = `Dice: ${status.dice}`;
  if (status.dice === 1) {
    alert('Oops..you died..');
      window.location.reload();
    
  }
  if (status.dice === 2) {
    alert('You had to take an unexpected detour. Double the amount of Co2 consumed.');
  }
  if (status.dice === 3) {
    alert(' Your planes GPS breaks and you ended up somewhere else.');
  }
  if (status.dice === 4) {
    alert('Your plane had to return to the previous airport. Full amount of Co2 wasted for that trip.');
  }
  if (status.dice === 5) {
    alert('You got a 50% Co2 refund for this flight.');
  }
  if (status.dice === 6) {
    alert('You got a full Co2 refund for this flight.');
  }
  console.log(status.dice);
}
// function to show weather at selected airport
function showWeather(airport) {
  document.querySelector('#airport-temp').innerHTML = `${airport.weather.temp}°C`;
  document.querySelector('#weather-icon').src = airport.weather.icon;
}

function showCountriesData(airport){
  document.querySelector('#current-country').innerHTML = `${airport.country_data.country}`;
  document.querySelector('#population').innerHTML = `${airport.country_data.population}`;
  document.querySelector('#language').innerHTML = `${airport.country_data.language}`;
  document.querySelector('#currency').innerHTML = `${airport.country_data.currency}`;
  document.querySelector('#capital').innerHTML = `${airport.country_data.capital}`;
  document.querySelector('#flag').src = airport.country_data.flag;

}

// functions to check if game is over
function checkGameOver(budget) {
  if (budget <= 0) {
    alert(`Game Over. You ran out of CO2 budget`)
    window.location.reload();
    return false;

  }
  return true;
}

function checkGameOverDice(dice) {
  if (dice === 1) {
    alert(`Game Over. You're dead`);
    window.location.reload();
    return false;

  }
  return true;
}

function checkGameOverCountries(countries) {
    if (countries === 10){
      document.getElementById("map").style.filter = "hue-rotate(96deg)"
      document.querySelector('#purification').innerHTML = "Purification: " + 20 + "%"
    }
    if (countries === 20){
      document.getElementById("map").style.filter = "hue-rotate(72deg)"
      document.querySelector('#purification').innerHTML = "Purification: " + 40 + "%"
    }
    if (countries === 30){
      document.getElementById("map").style.filter = "hue-rotate(48deg)"
      document.querySelector('#purification').innerHTML = "Purification: " + 60 + "%"
    }
    if (countries === 40){
      document.getElementById("map").style.filter = "hue-rotate(24deg)"
      document.querySelector('#purification').innerHTML = "Purification: " + 80 + "%"
    }
    if (countries === 50){
      document.getElementById("map").style.filter = "hue-rotate(0deg)"
      document.querySelector('#purification').innerHTML = "Purification: " + 100 + "%"
    }
  
  if (countries === 50) {
    alert(`Congratulation! You purified all the 50 countries!`);
    window.location.reload();
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
      if (!checkGameOverCountries(gameData.status.collected_countries)) return;
      
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
