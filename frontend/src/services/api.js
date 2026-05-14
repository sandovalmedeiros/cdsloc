import axios from 'axios'
// API Configuration
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8001';

export const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// API Endpoints
export const API_ENDPOINTS = {
  // Health
  HEALTH: '/health',

  // Catalog
  TITLES: '/catalog/titulos',
  TITULO_BY_ID: (id) => `/catalog/titulos/${id}`,
  CDS: '/catalog/cds',
  CD_BY_CODE: (code) => `/catalog/cds/${code}`,
  TITULO_CDS: (id) => `/catalog/titulos/${id}/cds`,

  // Customers
  CLIENTES: '/customers',
  CLIENTE_BY_ID: (id) => `/customers/${id}`,
  DEPENDENTES: '/customers/dependentes',
  CLIENTE_DEPENDENTES: (id) => `/customers/${id}/dependentes`,

  // Rentals
  LOCACOES: '/rentals/locacoes',
  LOCACAO_BY_ID: (id) => `/rentals/locacoes/${id}`,
  LOCACOES_PENDENTES: '/rentals/locacoes/pendentes',
  DEVOLUCAO: (id) => `/rentals/locacoes/${id}/devolucao`,
  RECIBOS_PENDENTES: '/rentals/clientes/{id}/recibos-pendentes',

  // Reservations
  RESERVAS: '/reservas',
  RESERVA_BY_ID: (id) => `/reservas/${id}`,
  CONFIRMAR_RESERVA: (id) => `/reservas/${id}/confirmar`,
  CANCELAR_RESERVA: (id) => `/reservas/${id}/cancelar`,
  CLIENTE_RESERVAS: (id) => `/reservas/clientes/${id}`,

  // Reports
  REPORTS_GERAR: '/reports/gerar',
  REPORTS_TIPOS: '/reports/tipos',
};

// API Service Functions
export const apiService = {
  // Health Check
  async healthCheck() {
    const response = await apiClient.get(API_ENDPOINTS.HEALTH);
    return response.data;
  },

  // Catalog
  async getTitulos(params = {}) {
    const response = await apiClient.get(API_ENDPOINTS.TITLES, { params });
    return response.data;
  },

  async getTitulo(id) {
    const response = await apiClient.get(API_ENDPOINTS.TITULO_BY_ID(id));
    return response.data;
  },

  async getCDs(params = {}) {
    const response = await apiClient.get(API_ENDPOINTS.CDS, { params });
    return response.data;
  },

  async getCDByCode(code) {
    const response = await apiClient.get(API_ENDPOINTS.CD_BY_CODE(code));
    return response.data;
  },

  async getTituloCDs(id) {
    const response = await apiClient.get(API_ENDPOINTS.TITULO_CDS(id));
    return response.data;
  },

  // Customers
  async getClientes(params = {}) {
    const response = await apiClient.get(API_ENDPOINTS.CLIENTES, { params });
    return response.data;
  },

  async getCliente(id) {
    const response = await apiClient.get(API_ENDPOINTS.CLIENTE_BY_ID(id));
    return response.data;
  },

  async createCliente(data) {
    const response = await apiClient.post(API_ENDPOINTS.CLIENTES, data);
    return response.data;
  },

  async updateCliente(id, data) {
    const response = await apiClient.put(API_ENDPOINTS.CLIENTE_BY_ID(id), data);
    return response.data;
  },

  async createDependente(clienteId, data) {
    const response = await apiClient.post(
      `${API_ENDPOINTS.CLIENTES}/${clienteId}/dependentes`,
      data
    );
    return response.data;
  },

  // Rentals
  async getLocacoes(params = {}) {
    const response = await apiClient.get(API_ENDPOINTS.LOCACOES, { params });
    return response.data;
  },

  async getLocacao(id) {
    const response = await apiClient.get(API_ENDPOINTS.LOCACAO_BY_ID(id));
    return response.data;
  },

  async createLocacao(data) {
    const response = await apiClient.post(API_ENDPOINTS.LOCACOES, data);
    return response.data;
  },

  async registrarDevolucao(locacaoId, data) {
    const response = await apiClient.post(
      API_ENDPOINTS.DEVOLUCAO(locacaoId),
      data
    );
    return response.data;
  },

  async getLocacoesPendentes() {
    const response = await apiClient.get(API_ENDPOINTS.LOCACOES_PENDENTES);
    return response.data;
  },

  // Reservations
  async getReservas(params = {}) {
    const response = await apiClient.get(API_ENDPOINTS.RESERVAS, { params });
    return response.data;
  },

  async getReserva(id) {
    const response = await apiClient.get(API_ENDPOINTS.RESERVA_BY_ID(id));
    return response.data;
  },

  async createReserva(data) {
    const response = await apiClient.post(API_ENDPOINTS.RESERVAS, data);
    return response.data;
  },

  async confirmarReserva(id) {
    const response = await apiClient.post(API_ENDPOINTS.CONFIRMAR_RESERVA(id));
    return response.data;
  },

  async cancelarReserva(id) {
    const response = await apiClient.post(API_ENDPOINTS.CANCELAR_RESERVA(id));
    return response.data;
  },

  async getClienteReservas(clienteId) {
    const response = await apiClient.get(API_ENDPOINTS.CLIENTE_RESERVAS(clienteId));
    return response.data;
  },

  // Reports
  async getTiposRelatorio() {
    const response = await apiClient.get(API_ENDPOINTS.REPORTS_TIPOS);
    return response.data;
  },

  async gerarRelatorio(data) {
    const response = await apiClient.post(API_ENDPOINTS.REPORTS_GERAR, data, {
      responseType: data.formato === 'pdf' ? 'blob' : 'text',
    });
    return response.data;
  },
};

export default apiService;
