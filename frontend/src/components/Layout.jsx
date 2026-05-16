import React, { useState, useEffect } from 'react';
import { Outlet, Link, useLocation } from 'react-router-dom';
import {
  LayoutDashboard,
  Disc,
  Users,
  Calendar,
  FileText,
  Menu,
  X,
  LogOut,
} from 'lucide-react';

export function Layout() {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [apiStatus, setApiStatus] = useState('connecting');
  const location = useLocation();

  useEffect(() => {
    // Check API health
    const checkHealth = async () => {
      try {
        await apiService.healthCheck();
        setApiStatus('connected');
      } catch (error) {
        setApiStatus('error');
      }
    };

    checkHealth();
    const interval = setInterval(checkHealth, 30000); // Check every 30s

    return () => clearInterval(interval);
  }, []);

  const navigation = [
    { name: 'Dashboard', href: '/dashboard', icon: LayoutDashboard },
    { name: 'Catálogo', href: '/catalogo', icon: Disc },
    { name: 'Clientes', href: '/clientes', icon: Users },
    { name: 'Locações', href: '/locacoes', icon: Calendar },
    { name: 'Reservas', href: '/reservas', icon: Calendar },
    { name: 'Relatórios', href: '/relatorios', icon: FileText },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Mobile sidebar overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 bg-gray-600 bg-opacity-75 z-40 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <div
        className={`fixed inset-y-0 left-0 z-50 w-64 bg-white shadow-lg transform transition-transform duration-300 ease-in-out lg:translate-x-0 ${
          sidebarOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        <div className="flex flex-col h-full">
          {/* Header */}
          <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200">
            <div className="flex items-center space-x-2">
              <Disc className="w-8 h-8 text-primary-600" />
              <span className="text-xl font-bold text-gray-900">CDsLoc</span>
            </div>
            <button
              onClick={() => setSidebarOpen(false)}
              className="lg:hidden text-gray-500 hover:text-gray-700"
            >
              <X className="w-6 h-6" />
            </button>
          </div>

          {/* Navigation */}
          <nav className="flex-1 px-4 py-6 space-y-1">
            {navigation.map((item) => {
              const isActive = location.pathname === item.href;
              return (
                <Link
                  key={item.name}
                  to={item.href}
                  className={`flex items-center space-x-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                    isActive
                      ? 'bg-primary-50 text-primary-700'
                      : 'text-gray-700 hover:bg-gray-100'
                  }`}
                >
                  <item.icon className="w-5 h-5" />
                  <span>{item.name}</span>
                </Link>
              );
            })}
          </nav>

          {/* Footer */}
          <div className="px-6 py-4 border-t border-gray-200">
            <div className="flex items-center justify-between mb-2">
              <span className="text-xs text-gray-500">API Status</span>
              <span
                className={`text-xs font-medium ${
                  apiStatus === 'connected'
                    ? 'text-green-600'
                    : apiStatus === 'error'
                    ? 'text-red-600'
                    : 'text-yellow-600'
                }`}
              >
                {apiStatus === 'connected' && '✓ Conectado'}
                {apiStatus === 'error' && '✗ Erro'}
                {apiStatus === 'connecting' && '⏳ Conectando...'}
              </span>
            </div>
            <button
              onClick={() => {
                window.location.href = '/';
              }}
              className="flex items-center space-x-2 text-sm text-gray-600 hover:text-gray-900"
            >
              <LogOut className="w-4 h-4" />
              <span>Sair</span>
            </button>
          </div>
        </div>
      </div>

      {/* Main content */}
      <div className="lg:pl-64">
        {/* Top bar */}
        <div className="sticky top-0 z-30 bg-white shadow-sm border-b border-gray-200">
          <div className="flex items-center justify-between px-4 py-3">
            <button
              onClick={() => setSidebarOpen(true)}
              className="lg:hidden text-gray-500 hover:text-gray-700"
            >
              <Menu className="w-6 h-6" />
            </button>
            <h1 className="text-lg font-semibold text-gray-900">
              Sistema de Locação de CDs
            </h1>
            <div className="flex items-center space-x-4">
              <span className="text-sm text-gray-500">v1.0.0</span>
            </div>
          </div>
        </div>

        {/* Page content */}
        <main className="p-6">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
