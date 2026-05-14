import React, { useState, useEffect } from 'react';
import { apiService } from '../services/api';
import { Calendar, Plus, RotateCcw } from 'lucide-react';

export function Locacoes() {
  const [locacoes, setLocacoes] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadLocacoes();
  }, []);

  const loadLocacoes = async () => {
    try {
      setLoading(true);
      const data = await apiService.getLocacoes();
      setLocacoes(data);
    } catch (error) {
      console.error('Error loading rentals:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Locações</h2>
          <p className="text-gray-600">Gerencie locações e devoluções</p>
        </div>
        <button className="flex items-center space-x-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition-colors">
          <Plus className="w-5 h-5" />
          <span>Nova Locação</span>
        </button>
      </div>

      {loading ? (
        <div className="text-center py-12 text-gray-500">Carregando locações...</div>
      ) : (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">ID</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Cliente</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">CD</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Data Locação</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Data Prevista</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Ações</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {locacoes.map((locacao) => (
                <tr key={locacao.id} className="hover:bg-gray-50">
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{locacao.id}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{locacao.id_cliente}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{locacao.itens[0]?.id_cd}</td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {new Date(locacao.data_locacao).toLocaleDateString()}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {locacao.data_prevista}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span
                      className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                        locacao.situacao === 'Pendente'
                          ? 'bg-orange-100 text-orange-800'
                          : 'bg-green-100 text-green-800'
                      }`}
                    >
                      {locacao.situacao}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    {locacao.situacao === 'Pendente' && (
                      <button className="text-blue-600 hover:text-blue-900 flex items-center space-x-1">
                        <RotateCcw className="w-4 h-4" />
                        <span>Devolver</span>
                      </button>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
