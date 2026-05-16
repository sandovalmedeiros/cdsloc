import React, { useState, useEffect } from 'react';
import { apiService } from '../services/api';
import { LayoutDashboard, Disc, Users, Calendar, FileText } from 'lucide-react';

export function Dashboard() {
  const [stats, setStats] = useState({
    totalCDs: 0,
    totalClientes: 0,
    locacoesAtivas: 0,
    reservasPendentes: 0,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadStats = async () => {
      try {
        // Fetch stats from API
        const data = await apiService.getDashboardStats();

        setStats({
          totalCDs: data.totalCDs || 0,
          totalClientes: data.totalClientes || 0,
          locacoesAtivas: data.locacoesAtivas || 0,
          reservasPendentes: data.reservasPendentes || 0,
        });
      } catch (error) {
        console.error('Error loading stats:', error);
      } finally {
        setLoading(false);
      }
    };

    loadStats();
  }, []);

  const statCards = [
    {
      title: 'Total de CDs',
      value: stats.totalCDs,
      icon: Disc,
      color: 'bg-blue-500',
      textColor: 'text-blue-600',
    },
    {
      title: 'Total de Clientes',
      value: stats.totalClientes,
      icon: Users,
      color: 'bg-green-500',
      textColor: 'text-green-600',
    },
    {
      title: 'Locações Ativas',
      value: stats.locacoesAtivas,
      icon: Calendar,
      color: 'bg-orange-500',
      textColor: 'text-orange-600',
    },
    {
      title: 'Reservas Pendentes',
      value: stats.reservasPendentes,
      icon: FileText,
      color: 'bg-purple-500',
      textColor: 'text-purple-600',
    },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-900">Dashboard</h2>
        <p className="text-gray-600">Visão geral do sistema de locação</p>
      </div>

      {loading ? (
        <div className="text-center py-12 text-gray-500">Carregando...</div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {statCards.map((stat) => (
            <div
              key={stat.title}
              className="bg-white rounded-lg shadow-sm border border-gray-200 p-6"
            >
              <div className="flex items-center justify-between mb-4">
                <div className={`p-3 rounded-lg ${stat.color}`}>
                  <stat.icon className="w-6 h-6 text-white" />
                </div>
                <span className={`text-sm font-medium text-gray-500`}>
                  Total
                </span>
              </div>
              <div className="flex items-end justify-between">
                <div>
                  <p className="text-sm text-gray-500">{stat.title}</p>
                  <p className="text-3xl font-bold text-gray-900">
                    {stat.value}
                  </p>
                </div>
                <stat.icon className={`w-8 h-8 ${stat.textColor} opacity-20`} />
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Recent Activity */}
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
        <h3 className="text-lg font-semibold text-gray-900 mb-4">
          Atividades Recentes
        </h3>
        <div className="space-y-4">
          <div className="flex items-center space-x-4 text-sm">
            <div className="flex-shrink-0 w-2 h-2 bg-green-500 rounded-full"></div>
            <span className="text-gray-600">Nova locação criada</span>
            <span className="ml-auto text-gray-400">2 min atrás</span>
          </div>
          <div className="flex items-center space-x-4 text-sm">
            <div className="flex-shrink-0 w-2 h-2 bg-blue-500 rounded-full"></div>
            <span className="text-gray-600">Cliente cadastrado</span>
            <span className="ml-auto text-gray-400">15 min atrás</span>
          </div>
          <div className="flex items-center space-x-4 text-sm">
            <div className="flex-shrink-0 w-2 h-2 bg-orange-500 rounded-full"></div>
            <span className="text-gray-600">Devolução registrada</span>
            <span className="ml-auto text-gray-400">1 hora atrás</span>
          </div>
        </div>
      </div>
    </div>
  );
}
