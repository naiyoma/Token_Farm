import React from 'react';
import logo from './logo.svg';
import { Header } from './components/Header';
import { ChainId } from '@usedapp/core';
import './App.css';
import { DAppProvider } from '@usedapp/core';
import { Container } from "@material-ui/core"
import { Main } from "./components/Main"



function App() {
  return (
    <DAppProvider config={{
      supportedChains: [ChainId.Kovan, ChainId.Rinkeby]
    }}>
      <Header />
      <Container>
        <div>Hi</div>
        <Main />
      </Container>
    </DAppProvider>
  );
}

export default App;
