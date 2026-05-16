import React, { useState, useEffect } from 'react';
import { apiService } from '../services/api';
import { Users, Plus, Search, Edit, Trash2 } from 'lucide-react';

export function Clientes() {
  const [clientes, setClientes] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [selectedCliente, setSelectedCliente] = useState(null);
  const [formData, setFormData] = useState({
    nomecliente: '',
    endereco: '',
    data_nascimento: '',
    cep: '',
    fone_01: '',
    fone_02: '',
    identidade: '',
    cic: '',
    cdbairro: 1,
    obs: '',
  });

  useEffect(() => {
    loadClientes();
  }, [searchTerm]);

  const loadClientes = async () => {
    try {
      setLoading(true);
      const data = await apiService.getClientes(searchTerm ? { search: searchTerm } : {});
      setClientes(data);
    } catch (error) {
      console.error('Error loading customers:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleNovoCliente = () => {
    setSelectedCliente(null);
    setFormData({
      nomecliente: '',
      endereco: '',
      data_nascimento: '1990-01-01',
      cep: '',
      fone_01: '',
      fone_02: '',
      identidade: '',
      cic: '',
      cdbairro: 1,
      obs: '',
    });
    setShowModal(true);
  };

  const handleEditCliente = (cliente) => {
    setSelectedCliente(cliente);
    setFormData({
      nomecliente: cliente.nomecliente || '',
      endereco: cliente.endereco || '',
      data_nascimento: cliente.data_nascimento || '1990-01-01',
      cep: cliente.cep || '',
      fone_01: cliente.fone_01 || '',
      fone_02: cliente.fone_02 || '',
      identidade: cliente.identidade || '',
      cic: cliente.cic || '',
      cdbairro: cliente.cdbairro || 1,
      obs: cliente.obs || '',
    });
    setShowModal(true);
  };

  const handleSaveCliente = async (e) => {
    e.preventDefault();
    try {
      console.log('=== Starting customer save ===');
      console.log('Form data:', formData);

      // Format CEP if needed (ensure XXXXX-XXX format)
      let cep = formData.cep || '';
      if (cep && !cep.includes('-') && cep.length === 8) {
        cep = `${cep.slice(0, 5)}-${cep.slice(5)}`;
      } else if (!cep) {
        cep = '00000-000'; // Default CEP
      }

      // Format phone (remove non-digits)
      const fone_01 = (formData.fone_01 || '').replace(/\D/g, '') || '00000000000';
      const fone_02 = (formData.fone_02 || '').replace(/\D/g, '') || null;

      // Format CPF (remove non-digits)
      const cic = (formData.cic || '').replace(/\D/g, '') || null;

      // Format RG (remove non-digits)
      const identidade = (formData.identidade || '').replace(/\D/g, '') || '000000000';

      // Prepare data with all fields
      const customerData = {
        nomecliente: formData.nomecliente,
        endereco: formData.endereco,
        data_nascimento: formData.data_nascimento || '1990-01-01',
        cdbairro: formData.cdbairro || 1,
        identidade: identidade,
        cep: cep,
        fone_01: fone_01,
        fone_02: fone_02,
        cic: cic,
        obs: formData.obs || null,
      };

      console.log('Sending to API:', JSON.stringify(customerData, null, 2));

      let response;
      if (selectedCliente) {
        console.log('Updating customer ID:', selectedCliente.id);
        response = await apiService.updateCliente(selectedCliente.id, customerData);
      } else {
        console.log('Creating new customer');
        response = await apiService.createCliente(customerData);
      }

      console.log('API Response:', response);

      setShowModal(false);
      await loadClientes();

      // Show success message
      alert('Cliente salvo com sucesso!');
    } catch (error) {
      console.error('=== ERROR saving customer ===');
      console.error('Error object:', error);
      console.error('Error response:', error.response);
      console.error('Error data:', error.response?.data);
      console.error('Error status:', error.response?.status);

      let errorMessage = 'Erro desconhecido';
      if (error.response?.data) {
        // Try to get detailed error from response
        const data = error.response.data;
        if (typeof data === 'string') {
          errorMessage = data;
        } else if (data.detail) {
          if (typeof data.detail === 'string') {
            errorMessage = data.detail;
          } else {
            errorMessage = JSON.stringify(data.detail);
          }
        } else {
          errorMessage = JSON.stringify(data);
        }
      } else if (error.message) {
        errorMessage = error.message;
      } else {
        errorMessage = JSON.stringify(error);
      }

      alert('Erro ao salvar cliente:\n\n' + errorMessage);
    }
  };

  const handleInputChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleDeleteCliente = async (id) => {
    if (window.confirm('Tem certeza que deseja excluir este cliente?')) {
      try {
        console.log('Deleting cliente:', id);
        await apiService.deleteCliente(id);
        await loadClientes();
        alert('Cliente excluído com sucesso!');
      } catch (error) {
        console.error('Error deleting customer:', error);
        let errorMessage = 'Erro desconhecido';
        if (error.response?.data) {
          const data = error.response.data;
          if (typeof data === 'string') {
            errorMessage = data;
          } else if (data.detail) {
            errorMessage = typeof data.detail === 'string' ? data.detail : JSON.stringify(data.detail);
          } else {
            errorMessage = JSON.stringify(data);
          }
        } else if (error.message) {
          errorMessage = error.message;
        }
        alert('Erro ao excluir cliente:\n\n' + errorMessage);
      }
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Clientes</h2>
          <p className="text-gray-600">Gerencie os clientes e dependentes</p>
        </div>
        <button
          onClick={handleNovoCliente}
          className="flex items-center space-x-2 bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 transition-colors"
        >
          <Plus className="w-5 h-5" />
          <span>Novo Cliente</span>
        </button>
      </div>

      {/* Search */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
        <input
          type="text"
          placeholder="Buscar clientes por nome..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
        />
      </div>

      {/* Clients Table */}
      {loading ? (
        <div className="text-center py-12 text-gray-500">Carregando clientes...</div>
      ) : (
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nome</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Endereço</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Telefone</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Ações</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {clientes.map((cliente) => (
                <tr key={cliente.id} className="hover:bg-gray-50">
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="flex items-center">
                      <Users className="w-8 h-8 text-gray-400 mr-3" />
                      <div>
                        <div className="text-sm font-medium text-gray-900">{cliente.nomecliente}</div>
                        <div className="text-xs text-gray-500">CPF: {cliente.cic || 'N/A'}</div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {cliente.endereco}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {cliente.fone_01 || 'N/A'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span
                      className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                        cliente.is_cancelado
                          ? 'bg-red-100 text-red-800'
                          : 'bg-green-100 text-green-800'
                      }`}
                    >
                      {cliente.is_cancelado ? 'Cancelado' : 'Ativo'}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <div className="flex justify-end space-x-2">
                      <button
                        onClick={() => handleEditCliente(cliente)}
                        className="text-blue-600 hover:text-blue-900"
                      >
                        <Edit className="w-5 h-5" />
                      </button>
                      <button
                        onClick={() => handleDeleteCliente(cliente.id)}
                        className="text-red-600 hover:text-red-900"
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

      {clientes.length === 0 && !loading && (
        <div className="text-center py-12 text-gray-500">
          <Users className="w-12 h-12 mx-auto mb-4 text-gray-300" />
          <p>Nenhum cliente encontrado</p>
        </div>
      )}

      {/* Modal de Cadastro/Edição */}
      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg p-6 max-w-2xl w-full max-h-[90vh] overflow-y-auto">
            <h3 className="text-lg font-semibold mb-4">
              {selectedCliente ? 'Editar Cliente' : 'Novo Cliente'}
            </h3>
            <form onSubmit={handleSaveCliente} className="space-y-4">
              {/* Dados Pessoais */}
              <div className="border-b pb-4 mb-4">
                <h4 className="font-medium text-gray-900 mb-3">Dados Pessoais</h4>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Nome Completo <span className="text-red-500">*</span>
                    </label>
                    <input
                      type="text"
                      name="nomecliente"
                      value={formData.nomecliente}
                      onChange={handleInputChange}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      required
                      placeholder="João Silva"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Data de Nascimento <span className="text-red-500">*</span>
                    </label>
                    <input
                      type="date"
                      name="data_nascimento"
                      value={formData.data_nascimento}
                      onChange={handleInputChange}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      required
                      max={new Date().toISOString().split('T')[0]}
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      CPF
                    </label>
                    <input
                      type="text"
                      name="cic"
                      value={formData.cic || ''}
                      onChange={handleInputChange}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      placeholder="000.000.000-00"
                      maxLength="14"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      RG (Identidade)
                    </label>
                    <input
                      type="text"
                      name="identidade"
                      value={formData.identidade || ''}
                      onChange={handleInputChange}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      placeholder="00.000.000-0"
                      maxLength="12"
                    />
                  </div>
                </div>
              </div>

              {/* Endereço */}
              <div className="border-b pb-4 mb-4">
                <h4 className="font-medium text-gray-900 mb-3">Endereço</h4>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Endereço <span className="text-red-500">*</span>
                    </label>
                    <input
                      type="text"
                      name="endereco"
                      value={formData.endereco}
                      onChange={handleInputChange}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      required
                      placeholder="Rua, número, complemento"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      CEP <span className="text-red-500">*</span>
                    </label>
                    <input
                      type="text"
                      name="cep"
                      value={formData.cep}
                      onChange={(e) => {
                        let value = e.target.value.replace(/\D/g, '');
                        if (value.length > 5) {
                          value = value.slice(0, 5) + '-' + value.slice(5, 8);
                        }
                        handleInputChange({ target: { name: 'cep', value } });
                      }}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      placeholder="00000-000"
                      maxLength="9"
                      required
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Bairro
                    </label>
                    <select
                      name="cdbairro"
                      value={formData.cdbairro || 1}
                      onChange={handleInputChange}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    >
                      <option value={1}>Centro</option>
                    </select>
                  </div>
                </div>
              </div>

              {/* Contatos */}
              <div className="border-b pb-4 mb-4">
                <h4 className="font-medium text-gray-900 mb-3">Contatos</h4>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Telefone Principal <span className="text-red-500">*</span>
                    </label>
                    <input
                      type="text"
                      name="fone_01"
                      value={formData.fone_01}
                      onChange={(e) => {
                        let value = e.target.value.replace(/\D/g, '');
                        if (value.length > 11) value = value.slice(0, 11);
                        handleInputChange({ target: { name: 'fone_01', value } });
                      }}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      placeholder="(11) 99999-9999"
                      maxLength="15"
                      required
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Telefone Secundário
                    </label>
                    <input
                      type="text"
                      name="fone_02"
                      value={formData.fone_02 || ''}
                      onChange={(e) => {
                        let value = e.target.value.replace(/\D/g, '');
                        if (value.length > 11) value = value.slice(0, 11);
                        handleInputChange({ target: { name: 'fone_02', value } });
                      }}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                      placeholder="(11) 99999-9999"
                      maxLength="15"
                    />
                  </div>
                </div>
              </div>

              {/* Observações */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Observações
                </label>
                <textarea
                  name="obs"
                  value={formData.obs || ''}
                  onChange={handleInputChange}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                  rows="3"
                  placeholder="Observações adicionais..."
                />
              </div>

              <div className="flex justify-end space-x-3 pt-4 border-t">
                <button
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors"
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
                >
                  {selectedCliente ? 'Atualizar' : 'Salvar'} Cliente
                </button>
              </div>

              <p className="text-xs text-gray-500 mt-2">
                * Campos obrigatórios
              </p>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
