import React, { Component } from 'react';
import '@cjdev/visual-stack/lib/global';

import Layout from '@cjdev/visual-stack/lib/layouts/ApplicationLayout';
import { PageHeader, PageTitle } from '@cjdev/visual-stack/lib/components/PageHeader';
import { TopNav } from '@cjdev/visual-stack/lib/components/TopNav';
import PageContent from '@cjdev/visual-stack/lib/components/PageContent';
import { Button } from '@cjdev/visual-stack/lib/components/Button';
import { SideNav, Link } from '@cjdev/visual-stack/lib/components/SideNav';

import qs from 'query-string';

const API_URL = process.env.REACT_APP_API_URL;
const WEBSITE_URL = process.env.REACT_APP_WEBSITE_URL;
const CLIENT_ID = process.env.REACT_APP_CLIENT_ID;

const AUTH_BASE_URL = 'http://staging-io.cjpowered.com';
const AUTH_URL = `${AUTH_BASE_URL}/auth?response_type=token&client_id=${CLIENT_ID}&redirect_uri=${encodeURIComponent(WEBSITE_URL)}`;

class App extends Component {
  state = { loggedIn: false };

  componentDidMount() {
    const hash = qs.parse(window.location.hash);
    const token = hash.access_token;
    if (token) {
      this.setState({ loggedIn: true })
      fetch('http://localhost:8080/greeting', {
        headers: { Authorization: `Bearer ${token}` }
      }).then(res => res.json())
        .then(json => {
          this.setState({ message: json.message })
        });
    }
  }

  render() {
    return (
      <Layout
        topNav={<TopNav appName="SUMMIT DEMO" />}
        sideNav={
          <SideNav>
            <Link><a href="http://www.cj.com">CJ Home</a></Link>
          </SideNav>
        }
      >
        <PageHeader>
          <PageTitle>{this.state.message}</PageTitle>
        </PageHeader>
        <PageContent>
          {!this.state.loggedIn &&
            <Button type="solid-primary" onClick={() => {
              window.location = `http://staging-io.cjpowered.com/auth?response_type=token&client_id=4znx2dxw7k519xkfmp4jv11cmq&redirect_uri=${encodeURIComponent('http://localhost:3000/')}`;
            }}>
              Log In
            </Button>}
        </PageContent>
      </Layout>
    );
  }
}

export default App;
