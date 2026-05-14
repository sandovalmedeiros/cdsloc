import React, { useState, useEffect } from 'react';
import { apiService } from '../services/api';
import { FileText, Download, Calendar } from 'lucide-react';

export function Relatorios() {
  const [reportTipos, setReportTipos] = useState([]);
  const [selectedTipo, setSelectedTipo] = useState('');
  const [periodo, setPeriodo] = useState('hoje');
  const [loading, setLoading] = useState(false);
  const [formato, setFormato] = useState('html');

  useEffect(() => {
    loadTipos();
  }, []);

  const loadTipos = async () => {
    try {
      const data = await apiService.getTiposRelatorio();
      setReportTipos(data);
    } catch (error) {
      console.error('Error loading report types:', error);
    }
  };

  const handleGerarRelatorio = async () => {
    if (!selectedTipo) {
      alert('Selecione um tipo de relatório');
      return;
    }

    try {
      setLoading(true);
      const data = await apiService.gerarRelatorio({
        tipo: selectedTipo,
        formato: formato,
        periodo: periodo,
      });

      if (formato === 'pdf') {
        // Download PDF
        const blob = new Blob([data], { type: 'application/pdf' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `${selectedTipo}.pdf`;
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
      } else {
        // Mostrar HTML em nova janela
        const newWindow = window.open('', '_blank');
        newWindow.document.write(data);
        newWindow.document.close();
      }
    } catch (error) {
      console.error('Error generating report:', error);
      alert('Erro ao gerar relatório');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-900">Relatórios</h2>
        <p className="text-gray-600">Gere relatórios HTML e PDF dos dados do sistema</p>
      </div>

      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <h3 className="text-lg font-semibold text-gray-900 mb-4">
          Configurar Relatório
        </h3>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Tipo de Relatório
            </label>
            <select
              value={selectedTipo}
              onChange={(e) => setSelectedTipo(e.target.value)}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary-500 focus:border-transparent"
            >
              <option value="">Selecione...</option>
              {reportTipos.map((tipo) => (
                <option key={tipo.id} value={tipo.tipo}>
                  {tipo.tipo.replace('_', ' ').toUpperCase()}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Formato
            </label>
            <select
              value={formato}
              onChange={(e) => setFormato(e.target.value)}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary-500 focus:border-transparent"
            >
              <option value="html">HTML</option>
              <option value="pdf">PDF</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Período
            </label>
            <select
              value={periodo}
              onChange={(e) => setPeriodo(e.target.value)}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-primary-500 focus:border-transparent"
            >
              <option value="hoje">Hoje</option>
              <option value="ontem">Ontem</option>
              <option value="esta_semana">Esta Semana</option>
              <option value="este_mes">Este Mês</option>
              <option value="ultimo_mes">Último Mês</option>
            </select>
          </div>

          <div className="flex items-end">
            <button
              onClick={handleGerarRelatorio}
              disabled={loading || !selectedTipo}
              className="w-full flex items-center justify-center space-x-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {loading ? (
                <span>Gerando...</span>
              ) : (
                <>
                  <Download className="w-5 h-5" />
                  <span>Gerar Relatório</span>
                </>
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Report Types Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {reportTipos.map((tipo) => (
          <div
            key={tipo.id}
            onClick={() => setSelectedTipo(tipo.tipo)}
            className={`bg-white rounded-lg shadow-sm border-2 p-6 cursor-pointer transition-all ${
              selectedTipo === tipo.tipo
                ? 'border-primary-500 shadow-md'
                : 'border-gray-200 hover:border-gray-300'
            }`}
          >
            <div className="flex items-start justify-between mb-4">
              <FileText className="w-8 h-8 text-primary-600" />
              <span className="text-xs text-gray-500 bg-gray-100 px-2 py-1 rounded">
                {tipo.tipo}
              </span>
            </div>
            <h4 className="text-lg font-semibold text-gray-900 mb-2">
              {tipo.tipo.replace('_', ' ').toUpperCase()}
            </h4>
            <p className="text-sm text-gray-500">
              {tipo.descricao || 'Relatório disponível em HTML e PDF'}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
}
