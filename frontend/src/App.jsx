import React from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { Layout } from './components/Layout';
import { Dashboard } from './pages/Dashboard';
import { Catalogo } from './pages/Catalogo';
import { Clientes } from './pages/Clientes';
import { Locacoes } from './pages/Locacoes';
import { Reservas } from './pages/Reservas';
import { Relatorios } from './pages/Relatorios';
import { apiService } from './services/api';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Navigate to="/dashboard" replace />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="catalogo" element={<Catalogo />} />
          <Route path="clientes" element={<Clientes />} />
          <Route path="locacoes" element={<Locacoes />} />
          <Route path="reservas" element={<Reservas />} />
          <Route path="relatorios" element={<Relatorios />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
