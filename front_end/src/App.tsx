import React from 'react';
import logo from './logo.svg';
import './App.css';
import { Container } from "@material-ui/core"



function App() {
  return (
    <DAppProvider config={{
      supportedChains: [ChainId.Kovan, ChainId.Rinkeby]
    }}>
      <Header>
        <Container>
          <div>Hi</div>
        </Container>
      </Header>
    </DAppProvider>
  );
}

export default App;
