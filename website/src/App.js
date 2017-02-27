/* eslint-disable */
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
  state = {};

  componentDidMount() {
    const hash = qs.parse(window.location.hash);
    const token = hash.access_token;

    fetch(`${API_URL}/greeting`, {
      headers: { Authorization: `Bearer ${token}` }
    }).then(res => res.json())
      .then(json => {
        this.setState({ message: json.message })
      });
  }

  render() {
    return (
      <Layout
        topNav={<TopNav appName="FRUIT LOOPS" />}
        sideNav={
          <SideNav>
            <Link><a href="http://cj.com">CJ Home</a></Link>
          </SideNav>
        }
      >
        <PageHeader>
          <PageTitle>{this.state.message}</PageTitle>
        </PageHeader>
        <PageContent>
          <Button type="solid-primary" onClick={() => {
              window.location = AUTH_URL;
            }}>
            Log In
          </Button>
        </PageContent>
      </Layout>
    )
  }
}

export default App;
