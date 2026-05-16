import React, { useState, useEffect } from 'react';
import { apiService } from '../services/api';
import {
  Plus,
  CheckCircle,
  Calendar,
  User,
  Disc,
  DollarSign,
  AlertCircle,
  X,
} from 'lucide-react';

export function Locacoes() {
  const [locacoes, setLocacoes] = useState([]);
  const [clientes, setClientes] = useState([]);
  const [cds, setCds] = useState([]);
  const [view, setView] = useState('lista'); // 'lista', 'nova', 'devolucao'
  const [loading, setLoading] = useState(true);
  const [selectedLocacao, setSelectedLocacao] = useState(null);

  // Form state
  const [formData, setFormData] = useState({
    id_cliente: '',
    id_cd: '',
    id_dependente: '',
  });

  // Devolução form state
  const [devolucaoData, setDevolucaoData] = useState({
    data_devolucao: new Date().toISOString().split('T')[0],
  });

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      const [locacoesData, clientesData, cdsData] = await Promise.all([
        apiService.getLocacoesPendentes(),
        apiService.getClientes(),
        apiService.getCDs(),
      ]);

      setLocacoes(locacoesData || []);
      setClientes(clientesData || []);
      setCds(cdsData.filter((cd) => cd.situacao === 'Disponível') || []);
    } catch (error) {
      console.error('Error loading data:', error);
      alert('Erro ao carregar dados: ' + (error.response?.data?.detail || error.message));
    } finally {
      setLoading(false);
    }
  };

  const handleNovaLocacao = async (e) => {
    e.preventDefault();
    try {
      const rentalData = {
        id_cliente: parseInt(formData.id_cliente),
        id_cd: formData.id_cd,
        id_dependente: formData.id_dependente ? parseInt(formData.id_dependente) : null,
        data_locacao: new Date().toISOString(),
      };

      await apiService.createLocacao(rentalData);
      alert('Locação criada com sucesso!');
      setView('lista');
      setFormData({ id_cliente: '', id_cd: '', id_dependente: '' });
      await loadData();
    } catch (error) {
      console.error('Error creating rental:', error);
      const errorMsg =
        typeof error.response?.data?.detail === 'string'
          ? error.response.data.detail
          : error.response?.data?.detail
          ? JSON.stringify(error.response.data.detail)
          : error.message;
      alert('Erro ao criar locação:\n\n' + errorMsg);
    }
  };

  const handleDevolucao = (locacao) => {
    setSelectedLocacao(locacao);
    setView('devolucao');
  };

  const handleConfirmarDevolucao = async (e) => {
    e.preventDefault();
    if (!selectedLocacao) return;

    try {
      const result = await apiService.registrarDevolucao(selectedLocacao.id, {
        data_devolucao: devolucaoData.data_devolucao,
      });

      const mensagem =
        result.dias_atraso > 0
          ? `Devolução registrada com sucesso!\n\nDias de atraso: ${result.dias_atraso}\nMulta: R$ ${result.valor_multa}\nTotal pago: R$ ${result.valor_total}`
          : 'Devolução registrada com sucesso! Sem multas.';

      alert(mensagem);
      setView('lista');
      setSelectedLocacao(null);
      setDevolucaoData({ data_devolucao: new Date().toISOString().split('T')[0] });
      await loadData();
    } catch (error) {
      console.error('Error registering return:', error);
      const errorMsg =
        typeof error.response?.data?.detail === 'string'
          ? error.response.data.detail
          : error.response?.data?.detail
          ? JSON.stringify(error.response.data.detail)
          : error.message;
      alert('Erro ao registrar devolução:\n\n' + errorMsg);
    }
  };

  const getClienteNome = (id) => {
    const cliente = clientes.find((c) => c.id === id);
    return cliente ? cliente.nomecliente : 'Cliente não encontrado';
  };

  const getCDNome = (codigo) => {
    const cd = cds.find((c) => c.codigo === codigo);
    return cd ? cd.numcd : 'CD não encontrado';
  };

  const isLate = (dataPrevista) => {
    const hoje = new Date();
    const prevista = new Date(dataPrevista);
    return prevista < hoje;
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-gray-500">Carregando...</div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Locações</h2>
          <p className="text-gray-600">Gerenciamento de locações de CDs</p>
        </div>
        {view === 'lista' && (
          <button
            onClick={() => setView('nova')}
            className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            <Plus className="w-5 h-5" />
            Nova Locação
          </button>
        )}
      </div>

      {view === 'lista' && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="p-6 border-b border-gray-200">
            <h3 className="text-lg font-semibold text-gray-900">
              Locações Pendentes ({locacoes.length})
            </h3>
          </div>
          {locacoes.length === 0 ? (
            <div className="p-12 text-center text-gray-500">
              <Disc className="w-12 h-12 mx-auto mb-4 text-gray-400" />
              <p>Nenhuma locação pendente</p>
            </div>
          ) : (
            <div className="divide-y divide-gray-200">
              {locacoes.map((locacao) => (
                <div
                  key={locacao.id}
                  className="p-6 hover:bg-gray-50 transition-colors"
                >
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-2">
                        <User className="w-5 h-5 text-gray-400" />
                        <span className="font-medium text-gray-900">
                          {getClienteNome(locacao.id_cliente)}
                        </span>
                        {isLate(locacao.data_prevista) && (
                          <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-red-100 text-red-800">
                            <AlertCircle className="w-3 h-3 mr-1" />
                            Atrasada
                          </span>
                        )}
                      </div>
                      <div className="grid grid-cols-2 gap-4 text-sm text-gray-600">
                        <div className="flex items-center gap-2">
                          <Disc className="w-4 h-4" />
                          <span>CD: {locacao.itens?.[0]?.id_cd || 'N/A'}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <Calendar className="w-4 h-4" />
                          <span>
                            Prevista: {new Date(locacao.data_prevista).toLocaleDateString('pt-BR')}
                          </span>
                        </div>
                        <div className="flex items-center gap-2">
                          <DollarSign className="w-4 h-4" />
                          <span>Valor: R$ {locacao.valor_locacao}</span>
                        </div>
                      </div>
                    </div>
                    <button
                      onClick={() => handleDevolucao(locacao)}
                      className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700"
                    >
                      <CheckCircle className="w-4 h-4" />
                      Devolver
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {view === 'nova' && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="p-6 border-b border-gray-200">
            <div className="flex items-center justify-between">
              <h3 className="text-lg font-semibold text-gray-900">Nova Locação</h3>
              <button
                onClick={() => {
                  setView('lista');
                  setFormData({ id_cliente: '', id_cd: '', id_dependente: '' });
                }}
                className="text-gray-500 hover:text-gray-700"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>
          <form onSubmit={handleNovaLocacao} className="p-6 space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Cliente *
              </label>
              <select
                required
                value={formData.id_cliente}
                onChange={(e) => setFormData({ ...formData, id_cliente: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="">Selecione um cliente</option>
                {clientes.map((cliente) => (
                  <option key={cliente.id} value={cliente.id}>
                    {cliente.nomecliente}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                CD Físico *
              </label>
              <select
                required
                value={formData.id_cd}
                onChange={(e) => setFormData({ ...formData, id_cd: e.target.value })}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
                <option value="">Selecione um CD disponível</option>
                {cds.map((cd) => (
                  <option key={cd.codigo} value={cd.codigo}>
                    {cd.numcd} - {cd.id_titulo}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Dependente (opcional)
              </label>
              <input
                type="number"
                value={formData.id_dependente}
                onChange={(e) => setFormData({ ...formData, id_dependente: e.target.value })}
                placeholder="ID do dependente"
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              />
            </div>

            <div className="flex gap-3 pt-4">
              <button
                type="submit"
                className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
              >
                Criar Locação
              </button>
              <button
                type="button"
                onClick={() => {
                  setView('lista');
                  setFormData({ id_cliente: '', id_cd: '', id_dependente: '' });
                }}
                className="px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
              >
                Cancelar
              </button>
            </div>
          </form>
        </div>
      )}

      {view === 'devolucao' && selectedLocacao && (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200">
          <div className="p-6 border-b border-gray-200">
            <div className="flex items-center justify-between">
              <h3 className="text-lg font-semibold text-gray-900">Registrar Devolução</h3>
              <button
                onClick={() => {
                  setView('lista');
                  setSelectedLocacao(null);
                }}
                className="text-gray-500 hover:text-gray-700"
              >
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>
          <div className="p-6">
            <div className="mb-6 p-4 bg-gray-50 rounded-lg">
              <h4 className="font-medium text-gray-900 mb-2">Detalhes da Locação</h4>
              <dl className="grid grid-cols-2 gap-4 text-sm">
                <div>
                  <dt className="text-gray-500">Cliente</dt>
                  <dd className="font-medium">{getClienteNome(selectedLocacao.id_cliente)}</dd>
                </div>
                <div>
                  <dt className="text-gray-500">Data Locação</dt>
                  <dd className="font-medium">
                    {new Date(selectedLocacao.data_locacao).toLocaleDateString('pt-BR')}
                  </dd>
                </div>
                <div>
                  <dt className="text-gray-500">Data Prevista</dt>
                  <dd className="font-medium">
                    {new Date(selectedLocacao.data_prevista).toLocaleDateString('pt-BR')}
                  </dd>
                </div>
                <div>
                  <dt className="text-gray-500">Valor</dt>
                  <dd className="font-medium">R$ {selectedLocacao.valor_locacao}</dd>
                </div>
              </dl>
            </div>

            <form onSubmit={handleConfirmarDevolucao} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Data de Devolução *
                </label>
                <input
                  type="date"
                  required
                  max={new Date().toISOString().split('T')[0]}
                  value={devolucaoData.data_devolucao}
                  onChange={(e) =>
                    setDevolucaoData({ data_devolucao: e.target.value })
                  }
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                />
                <p className="mt-1 text-sm text-gray-500">
                  A multa será calculada automaticamente se houver atraso
                </p>
              </div>

              <div className="flex gap-3 pt-4">
                <button
                  type="submit"
                  className="flex-1 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700"
                >
                  Confirmar Devolução
                </button>
                <button
                  type="button"
                  onClick={() => {
                    setView('lista');
                    setSelectedLocacao(null);
                  }}
                  className="px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50"
                >
                  Cancelar
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
