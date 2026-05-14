import React, { useState, useEffect } from 'react';
import { apiService } from '../services/api';
import { Disc, Search, Plus, Filter } from 'lucide-react';

export function Catalogo() {
  const [cds, setCds] = useState([]);
  const [titulos, setTitulos] = useState([]);
  const [filtroTitulo, setFiltroTitulo] = useState('');
  const [filtroSituacao, setFiltroSituacao] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadData();
  }, [filtroTitulo, filtroSituacao]);

  const loadData = async () => {
    try {
      setLoading(true);
      const [cdsData, titulosData] = await Promise.all([
        apiService.getCDs(),
        apiService.getTitulos(),
      ]);
      setCds(cdsData);
      setTitulos(titulosData);
    } catch (error) {
      console.error('Error loading catalog:', error);
    } finally {
      setLoading(false);
    }
  };

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

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Catálogo de CDs</h2>
          <p className="text-gray-600">Gerencie os CDs disponíveis para locação</p>
        </div>
        <button className="flex items-center space-x-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition-colors">
          <Plus className="w-5 h-5" />
          <span>Novo CD</span>
        </button>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Buscar por título..."
              value={filtroTitulo}
              onChange={(e) => setFiltroTitulo(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
            />
          </div>
          <div>
            <Filter className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
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
        </div>
      </div>

      {/* CDs Grid */}
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
    </div>
  );
}
