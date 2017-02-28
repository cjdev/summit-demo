/* eslint-disable */
import React, { Component } from 'react';
import '@cjdev/visual-stack/lib/global';

import Layout from '@cjdev/visual-stack/lib/layouts/ApplicationLayout';
import { PageHeader, PageTitle } from '@cjdev/visual-stack/lib/components/PageHeader';
import { TopNav } from '@cjdev/visual-stack/lib/components/TopNav';
import PageContent from '@cjdev/visual-stack/lib/components/PageContent';
import { Button } from '@cjdev/visual-stack/lib/components/Button';
import { SideNav, Link } from '@cjdev/visual-stack/lib/components/SideNav';

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
    return (
    <Layout
      topNav={<TopNav appName="SNUFFLES" />}
      sideNav={
        <SideNav>
          <Link><a href="http://www.cj.com">CJ Home</a></Link>
        </SideNav>
      }
    >
    <PageHeader>
      <PageTitle>{this.state.message}</PageTitle>
    </PageHeader>
    </Layout>
  );
  }
}

export default App;
