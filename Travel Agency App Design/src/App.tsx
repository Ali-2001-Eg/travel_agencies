import { useState } from 'react';
import { LoginScreen } from './components/LoginScreen';
import { RegisterScreen } from './components/RegisterScreen';
import { CustomerView } from './components/CustomerView';
import { RepresentativeView } from './components/RepresentativeView';
import { SupplierView } from './components/SupplierView';
import { Moon, Sun, Globe, LogOut } from 'lucide-react';

type View = 'login' | 'register' | 'customer' | 'representative' | 'supplier';
type Language = 'en' | 'ar' | 'fr' | 'de' | 'es' | 'it' | 'ru';

const languages: { code: Language; name: string }[] = [
  { code: 'en', name: 'English' },
  { code: 'ar', name: 'العربية' },
  { code: 'fr', name: 'Français' },
  { code: 'de', name: 'Deutsch' },
  { code: 'es', name: 'Español' },
  { code: 'it', name: 'Italiano' },
  { code: 'ru', name: 'Русский' },
];

export default function App() {
  const [currentView, setCurrentView] = useState<View>('login');
  const [isDarkMode, setIsDarkMode] = useState(false);
  const [currentLanguage, setCurrentLanguage] = useState<Language>('en');
  const [showLanguageMenu, setShowLanguageMenu] = useState(false);
  const [userRole, setUserRole] = useState<'customer' | 'representative' | 'supplier' | null>(null);
  const [userName, setUserName] = useState<string>('');

  const handleLogin = (role: 'customer' | 'representative' | 'supplier', name: string) => {
    setUserRole(role);
    setUserName(name);
    setCurrentView(role);
  };

  const handleLogout = () => {
    setUserRole(null);
    setUserName('');
    setCurrentView('login');
  };

  const handleSwitchView = (view: 'customer' | 'representative' | 'supplier') => {
    setCurrentView(view);
  };

  // Show auth screens
  if (currentView === 'login' || currentView === 'register') {
    return (
      <div className={isDarkMode ? 'dark' : ''}>
        <div className="min-h-screen bg-gradient-to-br from-teal-50 via-blue-50 to-orange-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900 transition-colors duration-300">
          {/* Top Bar for Auth Screens */}
          <div className="absolute top-4 right-4 flex items-center space-x-3 z-50">
            {/* Language Selector */}
            <div className="relative">
              <button
                onClick={() => setShowLanguageMenu(!showLanguageMenu)}
                className="p-2.5 rounded-xl bg-white/80 dark:bg-gray-800/80 backdrop-blur-sm text-gray-700 dark:text-gray-300 hover:bg-white dark:hover:bg-gray-700 transition-all shadow-lg flex items-center space-x-2"
              >
                <Globe className="w-5 h-5" />
                <span className="text-sm hidden sm:inline">{currentLanguage.toUpperCase()}</span>
              </button>
              
              {showLanguageMenu && (
                <div className="absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-xl shadow-2xl border border-gray-200 dark:border-gray-700 py-2 z-50">
                  {languages.map((lang) => (
                    <button
                      key={lang.code}
                      onClick={() => {
                        setCurrentLanguage(lang.code);
                        setShowLanguageMenu(false);
                      }}
                      className={`w-full text-left px-4 py-2.5 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors ${
                        currentLanguage === lang.code
                          ? 'bg-teal-50 dark:bg-teal-900/20 text-teal-600 dark:text-teal-400'
                          : 'text-gray-700 dark:text-gray-300'
                      }`}
                    >
                      {lang.name}
                    </button>
                  ))}
                </div>
              )}
            </div>

            {/* Dark Mode Toggle */}
            <button
              onClick={() => setIsDarkMode(!isDarkMode)}
              className="p-2.5 rounded-xl bg-white/80 dark:bg-gray-800/80 backdrop-blur-sm text-gray-700 dark:text-gray-300 hover:bg-white dark:hover:bg-gray-700 transition-all shadow-lg"
              aria-label="Toggle dark mode"
            >
              {isDarkMode ? <Sun className="w-5 h-5" /> : <Moon className="w-5 h-5" />}
            </button>
          </div>

          {currentView === 'login' ? (
            <LoginScreen
              onLogin={handleLogin}
              onSwitchToRegister={() => setCurrentView('register')}
              isDarkMode={isDarkMode}
            />
          ) : (
            <RegisterScreen
              onRegister={handleLogin}
              onSwitchToLogin={() => setCurrentView('login')}
              isDarkMode={isDarkMode}
            />
          )}
        </div>
      </div>
    );
  }

  // Show main app
  return (
    <div className={isDarkMode ? 'dark' : ''}>
      <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors duration-300">
        {/* Header Navigation */}
        <header className="bg-white dark:bg-gray-800 shadow-sm border-b border-gray-200 dark:border-gray-700 sticky top-0 z-50">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex items-center justify-between h-16">
              {/* Logo */}
              <div className="flex items-center space-x-3">
                <div className="w-10 h-10 bg-gradient-to-br from-teal-500 to-orange-500 rounded-xl flex items-center justify-center shadow-lg">
                  <span className="text-white text-xl">🌴</span>
                </div>
                <div className="hidden sm:block">
                  <h1 className="text-gray-900 dark:text-white">EgyptTravel</h1>
                  <p className="text-xs text-gray-500 dark:text-gray-400">Agency Management</p>
                </div>
              </div>

              {/* View Switcher - Only for demo purposes */}
              <div className="hidden md:flex items-center space-x-2">
                {userRole === 'customer' && (
                  <button
                    onClick={() => handleSwitchView('customer')}
                    className="px-4 py-2 rounded-lg bg-gradient-to-r from-teal-500 to-teal-600 text-white shadow-lg"
                  >
                    Customer
                  </button>
                )}
                {userRole === 'representative' && (
                  <button
                    onClick={() => handleSwitchView('representative')}
                    className="px-4 py-2 rounded-lg bg-gradient-to-r from-orange-500 to-orange-600 text-white shadow-lg"
                  >
                    Representative
                  </button>
                )}
                {userRole === 'supplier' && (
                  <button
                    onClick={() => handleSwitchView('supplier')}
                    className="px-4 py-2 rounded-lg bg-gradient-to-r from-purple-500 to-purple-600 text-white shadow-lg"
                  >
                    Supplier
                  </button>
                )}
              </div>

              {/* Controls */}
              <div className="flex items-center space-x-2 sm:space-x-3">
                {/* User Info - Desktop */}
                <div className="hidden lg:flex items-center space-x-3 mr-2">
                  <div className="text-right">
                    <p className="text-sm text-gray-900 dark:text-white">{userName}</p>
                    <p className="text-xs text-gray-500 dark:text-gray-400 capitalize">{userRole}</p>
                  </div>
                  <div className="w-10 h-10 bg-gradient-to-br from-teal-500 to-orange-500 rounded-full flex items-center justify-center text-white shadow-lg">
                    {userName.split(' ').map(n => n[0]).join('').toUpperCase()}
                  </div>
                </div>

                {/* Language Selector */}
                <div className="relative">
                  <button
                    onClick={() => setShowLanguageMenu(!showLanguageMenu)}
                    className="p-2 rounded-lg bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600 transition-colors flex items-center space-x-1 sm:space-x-2"
                  >
                    <Globe className="w-4 h-4 sm:w-5 sm:h-5" />
                    <span className="text-xs sm:text-sm hidden sm:inline">{currentLanguage.toUpperCase()}</span>
                  </button>
                  
                  {showLanguageMenu && (
                    <div className="absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-lg shadow-lg border border-gray-200 dark:border-gray-700 py-1 z-50 max-h-64 overflow-y-auto">
                      {languages.map((lang) => (
                        <button
                          key={lang.code}
                          onClick={() => {
                            setCurrentLanguage(lang.code);
                            setShowLanguageMenu(false);
                          }}
                          className={`w-full text-left px-4 py-2 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors ${
                            currentLanguage === lang.code
                              ? 'bg-teal-50 dark:bg-teal-900/20 text-teal-600 dark:text-teal-400'
                              : 'text-gray-700 dark:text-gray-300'
                          }`}
                        >
                          {lang.name}
                        </button>
                      ))}
                    </div>
                  )}
                </div>

                {/* Dark Mode Toggle */}
                <button
                  onClick={() => setIsDarkMode(!isDarkMode)}
                  className="p-2 rounded-lg bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600 transition-colors"
                  aria-label="Toggle dark mode"
                >
                  {isDarkMode ? <Sun className="w-4 h-4 sm:w-5 sm:h-5" /> : <Moon className="w-4 h-4 sm:w-5 sm:h-5" />}
                </button>

                {/* Logout Button */}
                <button
                  onClick={handleLogout}
                  className="p-2 rounded-lg bg-red-100 dark:bg-red-900/30 text-red-600 dark:text-red-400 hover:bg-red-200 dark:hover:bg-red-900/50 transition-colors"
                  aria-label="Logout"
                >
                  <LogOut className="w-4 h-4 sm:w-5 sm:h-5" />
                </button>
              </div>
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main>
          {currentView === 'customer' && <CustomerView isDarkMode={isDarkMode} language={currentLanguage} userName={userName} />}
          {currentView === 'representative' && <RepresentativeView isDarkMode={isDarkMode} language={currentLanguage} userName={userName} />}
          {currentView === 'supplier' && <SupplierView isDarkMode={isDarkMode} language={currentLanguage} userName={userName} />}
        </main>
      </div>
    </div>
  );
}
