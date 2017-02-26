/* eslint-disable */
import React, { Component } from 'react';

const API_URL = process.env.REACT_APP_API_URL;
const WEBSITE_URL = process.env.REACT_APP_WEBSITE_URL;
const CLIENT_ID = process.env.REACT_APP_CLIENT_ID;

const AUTH_BASE_URL = 'http://staging-io.cjpowered.com';
const AUTH_URL = `${AUTH_BASE_URL}/auth?response_type=token&client_id=${CLIENT_ID}&redirect_uri=${encodeURIComponent(WEBSITE_URL)}`;

class App extends Component {
  state = {};

  componentDidMount() {
    fetch(`${API_URL}/greeting`)
      .then(res => res.json())
      .then(json => {
        this.setState({ message: json.message })
      });
  }

  render() {
    return <h1>{this.state.message}</h1>;
  }
}

export default App;
