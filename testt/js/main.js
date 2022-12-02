'use strict';
/* 1. show map using Leaflet library. (L comes from the Leaflet library) */

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

//form for player name
document.querySelector('#player-form').addEventListener('submit', function (evt) {
  evt.preventDefault();
  const playerName = document.querySelector('#player-input').value;
  document.querySelector('#player-modal').classList.add('hide');
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
  // document.querySelector('#player-name').innerHTML = `Player: ${status.name}`;
  document.querySelector('#consumed').innerHTML = status.co2.consumed;
  document.querySelector('#countries').innerHTML = status.countries;
  document.querySelector('#dice').innerHTML = status.dice;
  if (status.dice === 1) {
    alert('dice : 1');
  }
  if (status.dice === 2) {
    alert('dice : 2');
  }
  if (status.dice === 3) {
    alert('dice : 3');
  }
  if (status.dice === 4) {
    alert('dice : 4');
  }
  if (status.dice === 5) {
    alert('dice : 5');
  }
  if (status.dice === 6) {
    alert('dice : 6');
  }
  console.log(status.dice);
}
// function to show weather at selected airport
// function showWeather(airport) {
//   document.querySelector('#airport-name').innerHTML = `Weather at ${airport.name}`;
//   document.querySelector('#airport-temp').innerHTML = `${airport.weather.temp}°C`;
//   document.querySelector('#weather-icon').src = airport.weather.icon;
//   document.querySelector('#airport-conditions').innerHTML = airport.weather.description;
//   document.querySelector('#airport-wind').innerHTML = `${airport.weather.wind.speed}m/s`;
// }


// function to check if any goals have been reached

// function to update goal data and goal table in UI
// function updateGoals(goals){

// }
// function to check if game is over
function checkGameOver(budget) {
  if (budget <= 0) {
    alert(`Game Over. ${globalGoals.length} goals reached.`);
    return false;
  }
  return true;
}

// function to set up game

// this is the main function that creates the game and calls the other functions
async function gameSetup(url){
  try {
    const gameData = await getData(url);
    console.log(gameData);
    updateStatus(gameData.status);
    if (!checkGameOver(gameData.status.co2.budget)) return;
      for(let airport of gameData.location){
      const marker = L.marker([airport.latitude, airport.longitude]).addTo(map);
      if(airport.active){
        // showWeather(airport);
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

// gameSetup(apiUrl);
// event listener to hide goal splash