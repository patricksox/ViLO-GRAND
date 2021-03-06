import React, { Component } from 'react';
import './App.css';
import UserList from './UserList';
import ConceptList from './ConceptList';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={process.env.PUBLIC_URL + '/img/grandstack.png'} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to GRANDstack</h1>
        </header>
        
        <ConceptList />
        <UserList />
      </div>
    );
  }
}

export default App;
