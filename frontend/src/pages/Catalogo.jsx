import React, { useState, useEffect } from 'react';
import { apiService } from '../services/api';
import { Disc, Search, Plus, Filter, Edit, Trash2, List, Music, Users } from 'lucide-react';

export function Catalogo() {
  const [viewMode, setViewMode] = useState('titulos');
  const [cds, setCds] = useState([]);
  const [titulos, setTitulos] = useState([]);
  const [filtroTitulo, setFiltroTitulo] = useState('');
  const [filtroSituacao, setFiltroSituacao] = useState('');
  const [filtroTipo, setFiltroTipo] = useState('');
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [selectedTitulo, setSelectedTitulo] = useState(null);
  const [formData, setFormData] = useState({
    nome: '',
    tipo_locacao: '48h',
    valor: '',
    qtde: 1,
  });

  // New state for musicas and interpretes
  const [showMusicasModal, setShowMusicasModal] = useState(false);
  const [showInterpretesModal, setShowInterpretesModal] = useState(false);
  const [tituloForMusicas, setTituloForMusicas] = useState(null);
  const [tituloForInterpretes, setTituloForInterpretes] = useState(null);
  const [newMusica, setNewMusica] = useState('');
  const [newInterprete, setNewInterprete] = useState('');

  useEffect(() => {
    loadData();
  }, [filtroTitulo, filtroSituacao, filtroTipo]);

  const loadData = async () => {
    try {
      setLoading(true);

      // Use Promise.allSettled to handle partial failures
      const results = await Promise.allSettled([
        apiService.getCDs(),
        apiService.getTitulos(),
      ]);

      // Process CDs result
      if (results[0].status === 'fulfilled') {
        setCds(results[0].value);
      } else {
        console.error('Error loading CDs:', results[0].reason);
        setCds([]);
      }

      // Process titles result
      if (results[1].status === 'fulfilled') {
        setTitulos(results[1].value);
      } else {
        console.error('Error loading titles:', results[1].reason);
        setTitulos([]);
      }
    } catch (error) {
      console.error('Error loading catalog:', error);
    } finally {
      setLoading(false);
    }
  };

  // Filter titles
  const filteredTitulos = titulos.filter((titulo) => {
    const matchNome = !filtroTitulo || titulo.nome.toLowerCase().includes(filtroTitulo.toLowerCase());
    const matchTipo = !filtroTipo || titulo.tipo_locacao === filtroTipo;
    return matchNome && matchTipo;
  });

  // Filter CDs
  const filteredCDs = cds.filter((cd) => {
    const titulo = titulos.find((t) => t.id === cd.id_titulo);
    const matchTitulo = !filtroTitulo || titulo?.nome.toLowerCase().includes(filtroTitulo.toLowerCase());
    const matchSituacao = !filtroSituacao || cd.situacao === filtroSituacao;
    return matchTitulo && matchSituacao;
  });

  const getTituloNome = (id) => {
    const titulo = titulos.find((t) => t.id === id);
    return titulo?.nome || 'Desconhecido';
  };

  const getSituacaoColor = (situacao) => {
    switch (situacao) {
      case 'Disponível':
        return 'bg-green-100 text-green-800';
      case 'Locado':
        return 'bg-red-100 text-red-800';
      case 'Reservado':
        return 'bg-yellow-100 text-yellow-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  const getTipoLocacaoLabel = (tipo) => {
    return tipo === '24h' ? '24 Horas' : '48 Horas';
  };

  const handleNovoTitulo = () => {
    setSelectedTitulo(null);
    setFormData({ nome: '', tipo_locacao: '48h', valor: '', qtde: 1 });
    setShowModal(true);
  };

  const handleEditTitulo = (titulo) => {
    setSelectedTitulo(titulo);
    setFormData({
      nome: titulo.nome,
      tipo_locacao: titulo.tipo_locacao,
      valor: titulo.valor,
      qtde: titulo.qtde,
    });
    setShowModal(true);
  };

  const handleDeleteTitulo = async (id) => {
    if (window.confirm('Tem certeza que deseja excluir este título? Todos os CDs associados também serão excluídos.')) {
      try {
        await apiService.deleteTitulo(id);
        await loadData();
        alert('Título excluído com sucesso!');
      } catch (error) {
        console.error('Error deleting title:', error);

        let errorMessage = 'Erro desconhecido';
        let isValidationError = false;

        if (error.response) {
          // Handle specific HTTP status codes
          if (error.response.status === 400) {
            isValidationError = true;
            if (typeof error.response.data?.detail === 'string') {
              errorMessage = error.response.data.detail;
            } else if (error.response.data?.detail) {
              errorMessage = JSON.stringify(error.response.data.detail);
            }
          } else if (error.response.data?.detail) {
            errorMessage = typeof error.response.data.detail === 'string'
              ? error.response.data.detail
              : JSON.stringify(error.response.data.detail);
          } else if (error.response.statusText) {
            errorMessage = error.response.statusText;
          }
        } else if (error.message) {
          errorMessage = error.message;
        }

        // Show validation error with different styling
        if (isValidationError) {
          alert('⚠️ Não foi possível excluir o título:\n\n' + errorMessage);
        } else {
          alert('Erro ao excluir título: ' + errorMessage);
        }
      }
    }
  };

  const handleSaveTitulo = async () => {
    try {
      const tituloData = {
        nome: formData.nome,
        tipo_locacao: formData.tipo_locacao,
        valor: parseFloat(formData.valor),
        qtde: formData.qtde,
      };

      if (selectedTitulo) {
        await apiService.updateTitulo(selectedTitulo.id, tituloData);
      } else {
        await apiService.createTitle(tituloData);
      }

      setShowModal(false);
      await loadData();
      alert(selectedTitulo ? 'Título atualizado com sucesso!' : 'Título criado com sucesso!');
    } catch (error) {
      console.error('Error saving title:', error);
      let errorMessage = 'Erro desconhecido';
      if (error.response?.data?.detail) {
        errorMessage = typeof error.response.data.detail === 'string'
          ? error.response.data.detail
          : JSON.stringify(error.response.data.detail);
      } else if (error.message) {
        errorMessage = error.message;
      }
      alert('Erro ao salvar título:\n\n' + errorMessage);
    }
  };

  // Musicas handlers
  const handleOpenMusicas = async (titulo) => {
    setTituloForMusicas(titulo);
    setShowMusicasModal(true);
  };

  const handleAddMusica = async () => {
    if (!newMusica.trim()) return;

    try {
      await apiService.addMusicaToTitle(tituloForMusicas.id, { nome: newMusica });
      setNewMusica('');
      await loadData(); // Reload to get updated musicas
    } catch (error) {
      console.error('Error adding musica:', error);
      alert('Erro ao adicionar música: ' + (error.response?.data?.detail || error.message));
    }
  };

  // Interpretes handlers
  const handleOpenInterpretes = async (titulo) => {
    setTituloForInterpretes(titulo);
    setShowInterpretesModal(true);
  };

  const handleAddInterprete = async () => {
    if (!newInterprete.trim()) return;

    try {
      await apiService.addInterpreteToTitle(tituloForInterpretes.id, { nome: newInterprete });
      setNewInterprete('');
      await loadData(); // Reload to get updated interpretes
    } catch (error) {
      console.error('Error adding interprete:', error);
      alert('Erro ao adicionar intérprete: ' + (error.response?.data?.detail || error.message));
    }
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Catálogo</h2>
          <p className="text-gray-600">Gerencie títulos, CDs, músicas e intérpretes</p>
        </div>
        {viewMode === 'titulos' && (
          <button
            onClick={handleNovoTitulo}
            className="flex items-center space-x-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition-colors"
          >
            <Plus className="w-5 h-5" />
            <span>Novo Título</span>
          </button>
        )}
      </div>

      {/* View Mode Toggle */}
      <div className="flex space-x-2 bg-gray-100 p-1 rounded-lg self-start">
        <button
          onClick={() => setViewMode('titulos')}
          className={`flex items-center space-x-2 px-4 py-2 rounded-md transition-colors ${
            viewMode === 'titulos'
              ? 'bg-white text-primary-600 shadow-sm'
              : 'text-gray-600 hover:text-gray-900'
          }`}
        >
          <List className="w-4 h-4" />
          <span>Títulos</span>
        </button>
        <button
          onClick={() => setViewMode('cds')}
          className={`flex items-center space-x-2 px-4 py-2 rounded-md transition-colors ${
            viewMode === 'cds'
              ? 'bg-white text-primary-600 shadow-sm'
              : 'text-gray-600 hover:text-gray-900'
          }`}
        >
          <Disc className="w-4 h-4" />
          <span>CDs Físicos</span>
        </button>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder={viewMode === 'titulos' ? 'Buscar título...' : 'Buscar por título...'}
              value={filtroTitulo}
              onChange={(e) => setFiltroTitulo(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
            />
          </div>
          {viewMode === 'titulos' ? (
            <div>
              <Filter className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400 pointer-events-none" />
              <select
                value={filtroTipo}
                onChange={(e) => setFiltroTipo(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
              >
                <option value="">Todos os tipos</option>
                <option value="24h">24 Horas</option>
                <option value="48h">48 Horas</option>
              </select>
            </div>
          ) : (
            <div>
              <Filter className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400 pointer-events-none" />
              <select
                value={filtroSituacao}
                onChange={(e) => setFiltroSituacao(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
              >
                <option value="">Todas as situações</option>
                <option value="Disponível">Disponível</option>
                <option value="Locado">Locado</option>
                <option value="Reservado">Reservado</option>
              </select>
            </div>
          )}
        </div>
      </div>

      {/* Títulos View */}
      {viewMode === 'titulos' && (
        <>
          {loading ? (
            <div className="text-center py-12 text-gray-500">Carregando títulos...</div>
          ) : (
            <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nome</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tipo</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Valor</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Músicas</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Intérpretes</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Qtd. CDs</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Ações</th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {filteredTitulos.map((titulo) => (
                    <tr key={titulo.id} className="hover:bg-gray-50">
                      <td className="px-6 py-4 whitespace-nowrap">
                        <div className="text-sm font-medium text-gray-900">{titulo.nome}</div>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        <span className="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">
                          {getTipoLocacaoLabel(titulo.tipo_locacao)}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        R$ {parseFloat(titulo.valor).toFixed(2)}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        <button
                          onClick={() => handleOpenMusicas(titulo)}
                          className="flex items-center space-x-1 text-blue-600 hover:text-blue-800"
                        >
                          <Music className="w-4 h-4" />
                          <span>{titulo.musicas?.length || 0}</span>
                        </button>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        <button
                          onClick={() => handleOpenInterpretes(titulo)}
                          className="flex items-center space-x-1 text-purple-600 hover:text-purple-800"
                        >
                          <Users className="w-4 h-4" />
                          <span>{titulo.interpretes?.length || 0}</span>
                        </button>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {titulo.qtde}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                        <div className="flex justify-end space-x-2">
                          <button
                            onClick={() => handleEditTitulo(titulo)}
                            className="text-blue-600 hover:text-blue-900"
                            title="Editar"
                          >
                            <Edit className="w-5 h-5" />
                          </button>
                          <button
                            onClick={() => handleDeleteTitulo(titulo.id)}
                            className="text-red-600 hover:text-red-900"
                            title="Excluir"
                          >
                            <Trash2 className="w-5 h-5" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}

          {filteredTitulos.length === 0 && !loading && (
            <div className="text-center py-12 text-gray-500">
              <List className="w-12 h-12 mx-auto mb-4 text-gray-300" />
              <p>Nenhum título encontrado</p>
            </div>
          )}
        </>
      )}

      {/* CDs View */}
      {viewMode === 'cds' && (
        <>
          {loading ? (
            <div className="text-center py-12 text-gray-500">Carregando CDs...</div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
              {filteredCDs.map((cd) => (
                <div
                  key={cd.codigo}
                  className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden hover:shadow-md transition-shadow"
                >
                  <div className="bg-gradient-to-r from-primary-500 to-primary-600 h-32 flex items-center justify-center">
                    <Disc className="w-16 h-16 text-white opacity-50" />
                  </div>
                  <div className="p-4">
                    <div className="flex items-start justify-between mb-2">
                      <h3 className="text-lg font-semibold text-gray-900 truncate">
                        {getTituloNome(cd.id_titulo)}
                      </h3>
                      <span
                        className={`px-2 py-1 rounded-full text-xs font-medium ${getSituacaoColor(
                          cd.situacao
                        )}`}
                      >
                        {cd.situacao}
                      </span>
                    </div>
                    <div className="space-y-1 text-sm text-gray-600">
                      <p><span className="font-medium">Código:</span> {cd.codigo}</p>
                      <p><span className="font-medium">NumCD:</span> {cd.numcd}</p>
                      {cd.valor_cp && (
                        <p><span className="font-medium">Valor:</span> R$ {cd.valor_cp}</p>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}

          {filteredCDs.length === 0 && !loading && (
            <div className="text-center py-12 text-gray-500">
              <Disc className="w-12 h-12 mx-auto mb-4 text-gray-300" />
              <p>Nenhum CD encontrado</p>
            </div>
          )}
        </>
      )}

      {/* Modal for creating/editing title */}
      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-md w-full">
            <h3 className="text-lg font-semibold mb-4">
              {selectedTitulo ? 'Editar Título' : 'Novo Título'}
            </h3>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Nome *</label>
                <input
                  type="text"
                  value={formData.nome}
                  onChange={(e) => setFormData({ ...formData, nome: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  required
                  placeholder="Nome do título"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Tipo de Locação *</label>
                <select
                  value={formData.tipo_locacao}
                  onChange={(e) => setFormData({ ...formData, tipo_locacao: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                >
                  <option value="24h">24 Horas</option>
                  <option value="48h">48 Horas</option>
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Valor (R$) *</label>
                <input
                  type="number"
                  step="0.01"
                  min="0"
                  value={formData.valor}
                  onChange={(e) => setFormData({ ...formData, valor: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  required
                  placeholder="0.00"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Quantidade de CDs *</label>
                <input
                  type="number"
                  min="1"
                  value={formData.qtde}
                  onChange={(e) => setFormData({ ...formData, qtde: parseInt(e.target.value) || 0 })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  required
                />
                <p className="text-xs text-gray-500 mt-1">Os CDs físicos serão criados automaticamente</p>
              </div>
              <div className="flex justify-end space-x-3 pt-4 border-t">
                <button
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50"
                >
                  Cancelar
                </button>
                <button
                  type="button"
                  onClick={handleSaveTitulo}
                  className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700"
                >
                  {selectedTitulo ? 'Atualizar' : 'Salvar'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Modal for Musicas */}
      {showMusicasModal && tituloForMusicas && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-md w-full">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold">Músicas - {tituloForMusicas.nome}</h3>
              <button
                onClick={() => setShowMusicasModal(false)}
                className="text-gray-400 hover:text-gray-600"
              >
                ✕
              </button>
            </div>

            <div className="space-y-4">
              {/* Add new musica */}
              <div className="flex space-x-2">
                <input
                  type="text"
                  value={newMusica}
                  onChange={(e) => setNewMusica(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && handleAddMusica()}
                  className="flex-1 border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="Nome da música"
                />
                <button
                  onClick={handleAddMusica}
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
                >
                  <Plus className="w-4 h-4" />
                </button>
              </div>

              {/* List musicas */}
              <div className="max-h-60 overflow-y-auto border rounded-lg">
                {tituloForMusicas.musicas && tituloForMusicas.musicas.length > 0 ? (
                  <ul className="divide-y">
                    {tituloForMusicas.musicas.map((musica) => (
                      <li key={musica.id} className="px-4 py-2 flex items-center justify-between">
                        <div className="flex items-center space-x-2">
                          <Music className="w-4 h-4 text-gray-400" />
                          <span>{musica.nome}</span>
                        </div>
                      </li>
                    ))}
                  </ul>
                ) : (
                  <div className="px-4 py-8 text-center text-gray-500">
                    Nenhuma música cadastrada
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Modal for Interpretes */}
      {showInterpretesModal && tituloForInterpretes && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-md w-full">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold">Intérpretes - {tituloForInterpretes.nome}</h3>
              <button
                onClick={() => setShowInterpretesModal(false)}
                className="text-gray-400 hover:text-gray-600"
              >
                ✕
              </button>
            </div>

            <div className="space-y-4">
              {/* Add new interprete */}
              <div className="flex space-x-2">
                <input
                  type="text"
                  value={newInterprete}
                  onChange={(e) => setNewInterprete(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && handleAddInterprete()}
                  className="flex-1 border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="Nome do intérprete"
                />
                <button
                  onClick={handleAddInterprete}
                  className="px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700"
                >
                  <Plus className="w-4 h-4" />
                </button>
              </div>

              {/* List interpretes */}
              <div className="max-h-60 overflow-y-auto border rounded-lg">
                {tituloForInterpretes.interpretes && tituloForInterpretes.interpretes.length > 0 ? (
                  <ul className="divide-y">
                    {tituloForInterpretes.interpretes.map((interprete) => (
                      <li key={interprete.id} className="px-4 py-2 flex items-center justify-between">
                        <div className="flex items-center space-x-2">
                          <Users className="w-4 h-4 text-gray-400" />
                          <span>{interprete.nome}</span>
                        </div>
                      </li>
                    ))}
                  </ul>
                ) : (
                  <div className="px-4 py-8 text-center text-gray-500">
                    Nenhum intérprete cadastrado
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
