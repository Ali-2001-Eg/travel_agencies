import { useState } from 'react';
import { ImageWithFallback } from './figma/ImageWithFallback';
import { BookingModal } from './BookingModal';
import { ServiceRequestModal } from './ServiceRequestModal';
import { 
  Home, Compass, Calendar, HeartHandshake, Heart, 
  Search, QrCode, MapPin, Star, Clock, TrendingUp,
  Waves, Ship, Mountain, Music, Gift, Sparkles, Plus
} from 'lucide-react';

interface CustomerViewProps {
  isDarkMode: boolean;
  language: string;
  userName: string;
}

type TabType = 'home' | 'excursions' | 'events' | 'services' | 'favorites';

interface Excursion {
  id: number;
  name: string;
  location: string;
  price: number;
  image: string;
  category: 'Snorkeling' | 'Diving' | 'Safari' | 'Cultural' | 'Adventure';
  duration: string;
  rating: number;
  description: string;
}

interface Event {
  id: number;
  name: string;
  date: string;
  image: string;
  location: string;
  price: number;
  category: 'Night Life' | 'Christmas' | 'New Year' | 'Cultural';
  description: string;
}

interface Service {
  id: number;
  name: string;
  description: string;
  icon: string;
  available: boolean;
}

export function CustomerView({ isDarkMode, language, userName }: CustomerViewProps) {
  const [activeTab, setActiveTab] = useState<TabType>('home');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [showQRScanner, setShowQRScanner] = useState(false);
  const [favorites, setFavorites] = useState<number[]>([]);
  const [bookingModal, setBookingModal] = useState<{ isOpen: boolean; item: any; type: 'excursion' | 'event' | null }>({
    isOpen: false,
    item: null,
    type: null
  });
  const [serviceRequestModal, setServiceRequestModal] = useState<{ isOpen: boolean; service: any }>({
    isOpen: false,
    service: null
  });

  const excursions: Excursion[] = [
    {
      id: 1,
      name: 'Red Sea Snorkeling Adventure',
      location: 'Sharm El Sheikh',
      price: 45,
      image: 'https://images.unsplash.com/photo-1687708167574-9a9b4eac3a22?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzbm9ya2VsaW5nJTIwdW5kZXJ3YXRlciUyMGNvcmFsfGVufDF8fHx8MTc2NTM3Njc0M3ww&ixlib=rb-4.1.0&q=80&w=1080',
      category: 'Snorkeling',
      duration: '4 hours',
      rating: 4.8,
      description: 'Explore the beautiful coral reefs and colorful marine life'
    },
    {
      id: 2,
      name: 'Desert Safari Experience',
      location: 'Hurghada',
      price: 65,
      image: 'https://images.unsplash.com/photo-1741213651580-f1a708aa3c7d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxlZ3lwdCUyMGRlc2VydCUyMHNhZmFyaXxlbnwxfHx8fDE3NjU0OTQwNTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
      category: 'Safari',
      duration: '6 hours',
      rating: 4.9,
      description: 'Thrilling desert adventure with quad bikes and camel rides'
    },
    {
      id: 3,
      name: 'Professional Scuba Diving',
      location: 'Sharm El Sheikh',
      price: 95,
      image: 'https://images.unsplash.com/photo-1755335741608-b61342825917?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzY3ViYSUyMGRpdmluZyUyMHJlZCUyMHNlYXxlbnwxfHx8fDE3NjU0OTQwNTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
      category: 'Diving',
      duration: '5 hours',
      rating: 5.0,
      description: 'Deep sea diving experience with certified instructors'
    },
    {
      id: 4,
      name: 'Luxor Temples Tour',
      location: 'Luxor',
      price: 80,
      image: 'https://images.unsplash.com/photo-1693654547147-24d94b4ed4ea?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxsdXhvciUyMGVneXB0JTIwdGVtcGxlfGVufDF8fHx8MTc2NDMzMjgyM3ww&ixlib=rb-4.1.0&q=80&w=1080',
      category: 'Cultural',
      duration: '8 hours',
      rating: 4.9,
      description: 'Visit ancient Egyptian temples and monuments'
    },
    {
      id: 5,
      name: 'Bedouin Night Safari',
      location: 'Hurghada',
      price: 55,
      image: 'https://images.unsplash.com/photo-1741213651580-f1a708aa3c7d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxlZ3lwdCUyMGRlc2VydCUyMHNhZmFyaXxlbnwxfHx8fDE3NjU0OTQwNTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
      category: 'Safari',
      duration: '7 hours',
      rating: 4.7,
      description: 'Experience Bedouin culture with dinner and stargazing'
    },
    {
      id: 6,
      name: 'Parasailing Adventure',
      location: 'Sharm El Sheikh',
      price: 70,
      image: 'https://images.unsplash.com/photo-1687708167574-9a9b4eac3a22?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzbm9ya2VsaW5nJTIwdW5kZXJ3YXRlciUyMGNvcmFsfGVufDF8fHx8MTc2NTM3Njc0M3ww&ixlib=rb-4.1.0&q=80&w=1080',
      category: 'Adventure',
      duration: '2 hours',
      rating: 4.6,
      description: 'Soar above the Red Sea with breathtaking views'
    }
  ];

  const events: Event[] = [
    {
      id: 101,
      name: 'Christmas Beach Party',
      date: 'December 25, 2025',
      image: 'https://images.unsplash.com/photo-1576481564650-61d2ed81f6d5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjaHJpc3RtYXMlMjBwYXJ0eSUyMGNlbGVicmF0aW9ufGVufDF8fHx8MTc2NTQzNTMwNHww&ixlib=rb-4.1.0&q=80&w=1080',
      location: 'Sharm El Sheikh',
      price: 85,
      category: 'Christmas',
      description: 'Celebrate Christmas on the beach with music and food'
    },
    {
      id: 102,
      name: 'New Year Gala Night',
      date: 'December 31, 2025',
      image: 'https://images.unsplash.com/photo-1657208431551-cbf415b8ef26?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxuaWdodGNsdWIlMjBwYXJ0eSUyMGxpZ2h0c3xlbnwxfHx8fDE3NjU0OTQwNTl8MA&ixlib=rb-4.1.0&q=80&w=1080',
      location: 'Hurghada',
      price: 120,
      category: 'New Year',
      description: 'Ring in the new year with a spectacular celebration'
    },
    {
      id: 103,
      name: 'Night Club Experience',
      date: 'Every Friday & Saturday',
      image: 'https://images.unsplash.com/photo-1657208431551-cbf415b8ef26?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxuaWdodGNsdWIlMjBwYXJ0eSUyMGxpZ2h0c3xlbnwxfHx8fDE3NjU0OTQwNTl8MA&ixlib=rb-4.1.0&q=80&w=1080',
      location: 'Sharm El Sheikh',
      price: 50,
      category: 'Night Life',
      description: 'Premium nightclub experience with international DJs'
    },
    {
      id: 104,
      name: 'Egyptian Cultural Night',
      date: 'Every Thursday',
      image: 'https://images.unsplash.com/photo-1693654547147-24d94b4ed4ea?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxsdXhvciUyMGVneXB0JTIwdGVtcGxlfGVufDF8fHx8MTc2NDMzMjgyM3ww&ixlib=rb-4.1.0&q=80&w=1080',
      location: 'Luxor',
      price: 45,
      category: 'Cultural',
      description: 'Traditional Egyptian music, dance, and cuisine'
    }
  ];

  const services: Service[] = [
    { id: 201, name: 'Healthcare', description: '24/7 Medical Support', icon: '🏥', available: true },
    { id: 202, name: 'Spa & Massage', description: 'Relaxation Services', icon: '💆', available: true },
    { id: 203, name: 'Doctor Consultation', description: 'Online & In-person', icon: '👨‍⚕️', available: true },
    { id: 204, name: 'Airport Transfer', description: 'Private Transportation', icon: '🚗', available: true },
    { id: 205, name: 'Personal Trainer', description: 'Fitness & Wellness', icon: '💪', available: true },
    { id: 206, name: 'Tour Guide', description: 'Private Tours', icon: '🗺️', available: true }
  ];

  const toggleFavorite = (id: number) => {
    setFavorites(prev => 
      prev.includes(id) ? prev.filter(fav => fav !== id) : [...prev, id]
    );
  };

  const openBookingModal = (item: any, type: 'excursion' | 'event') => {
    setBookingModal({ isOpen: true, item, type });
  };

  const openServiceRequest = (service: any) => {
    setServiceRequestModal({ isOpen: true, service });
  };

  const filteredExcursions = excursions.filter(exc => {
    const matchesSearch = exc.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         exc.category.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCategory = selectedCategory === 'all' || exc.category === selectedCategory;
    return matchesSearch && matchesCategory;
  });

  const filteredEvents = events.filter(evt => 
    evt.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
    evt.category.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const favoriteExcursions = excursions.filter(exc => favorites.includes(exc.id));
  const favoriteEvents = events.filter(evt => favorites.includes(evt.id));

  const categories = [
    { name: 'all', icon: Compass, label: 'All' },
    { name: 'Snorkeling', icon: Waves, label: 'Snorkeling' },
    { name: 'Diving', icon: Ship, label: 'Diving' },
    { name: 'Safari', icon: Mountain, label: 'Safari' },
    { name: 'Cultural', icon: Gift, label: 'Cultural' },
    { name: 'Adventure', icon: Sparkles, label: 'Adventure' }
  ];

  // Render Home Tab
  const renderHomeTab = () => (
    <div className="space-y-6">
      {/* Quick Actions */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <button
          onClick={() => setActiveTab('excursions')}
          className="bg-gradient-to-br from-teal-500 to-teal-600 text-white p-6 rounded-2xl hover:shadow-xl transition-all group"
        >
          <Compass className="w-8 h-8 mb-3 group-hover:scale-110 transition-transform" />
          <h3 className="font-semibold mb-1">Excursions</h3>
          <p className="text-sm text-white/80">{excursions.length} Available</p>
        </button>
        
        <button
          onClick={() => setActiveTab('events')}
          className="bg-gradient-to-br from-orange-500 to-orange-600 text-white p-6 rounded-2xl hover:shadow-xl transition-all group"
        >
          <Calendar className="w-8 h-8 mb-3 group-hover:scale-110 transition-transform" />
          <h3 className="font-semibold mb-1">Events</h3>
          <p className="text-sm text-white/80">{events.length} Special</p>
        </button>
        
        <button
          onClick={() => setActiveTab('services')}
          className="bg-gradient-to-br from-purple-500 to-purple-600 text-white p-6 rounded-2xl hover:shadow-xl transition-all group"
        >
          <HeartHandshake className="w-8 h-8 mb-3 group-hover:scale-110 transition-transform" />
          <h3 className="font-semibold mb-1">Services</h3>
          <p className="text-sm text-white/80">{services.length} Available</p>
        </button>
        
        <button
          onClick={() => setShowQRScanner(true)}
          className="bg-gradient-to-br from-pink-500 to-pink-600 text-white p-6 rounded-2xl hover:shadow-xl transition-all group"
        >
          <QrCode className="w-8 h-8 mb-3 group-hover:scale-110 transition-transform" />
          <h3 className="font-semibold mb-1">Connect</h3>
          <p className="text-sm text-white/80">Scan QR Code</p>
        </button>
      </div>

      {/* Trending Excursions */}
      <section>
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center space-x-2">
            <TrendingUp className="w-6 h-6 text-teal-600 dark:text-teal-400" />
            <h2 className="text-xl text-gray-900 dark:text-white">Trending Excursions</h2>
          </div>
          <button
            onClick={() => setActiveTab('excursions')}
            className="text-teal-600 dark:text-teal-400 text-sm hover:underline"
          >
            View All
          </button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {excursions.slice(0, 3).map((excursion) => (
            <ExcursionCard
              key={excursion.id}
              excursion={excursion}
              isFavorite={favorites.includes(excursion.id)}
              onToggleFavorite={() => toggleFavorite(excursion.id)}
              onBook={() => openBookingModal(excursion, 'excursion')}
            />
          ))}
        </div>
      </section>

      {/* Upcoming Events */}
      <section>
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center space-x-2">
            <Sparkles className="w-6 h-6 text-orange-600 dark:text-orange-400" />
            <h2 className="text-xl text-gray-900 dark:text-white">Upcoming Events</h2>
          </div>
          <button
            onClick={() => setActiveTab('events')}
            className="text-orange-600 dark:text-orange-400 text-sm hover:underline"
          >
            View All
          </button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {events.slice(0, 2).map((event) => (
            <EventCard
              key={event.id}
              event={event}
              isFavorite={favorites.includes(event.id)}
              onToggleFavorite={() => toggleFavorite(event.id)}
              onBook={() => openBookingModal(event, 'event')}
            />
          ))}
        </div>
      </section>

      {/* Quick Services */}
      <section>
        <h2 className="text-xl text-gray-900 dark:text-white mb-4">Quick Services</h2>
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
          {services.map((service) => (
            <button
              key={service.id}
              onClick={() => openServiceRequest(service)}
              className="bg-white dark:bg-gray-800 p-4 rounded-xl hover:shadow-lg transition-all text-center group"
            >
              <div className="text-4xl mb-2 group-hover:scale-110 transition-transform">{service.icon}</div>
              <p className="text-sm text-gray-900 dark:text-white">{service.name}</p>
            </button>
          ))}
        </div>
      </section>
    </div>
  );

  // Render Excursions Tab
  const renderExcursionsTab = () => (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-2xl text-gray-900 dark:text-white">Explore Excursions</h2>
      </div>

      {/* Category Filter */}
      <div className="flex gap-2 overflow-x-auto pb-2">
        {categories.map((cat) => {
          const Icon = cat.icon;
          return (
            <button
              key={cat.name}
              onClick={() => setSelectedCategory(cat.name)}
              className={`flex items-center space-x-2 px-4 py-2 rounded-xl transition-all whitespace-nowrap ${
                selectedCategory === cat.name
                  ? 'bg-gradient-to-r from-teal-500 to-teal-600 text-white shadow-lg'
                  : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700'
              }`}
            >
              <Icon className="w-4 h-4" />
              <span>{cat.label}</span>
            </button>
          );
        })}
      </div>

      {/* Excursions Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredExcursions.map((excursion) => (
          <ExcursionCard
            key={excursion.id}
            excursion={excursion}
            isFavorite={favorites.includes(excursion.id)}
            onToggleFavorite={() => toggleFavorite(excursion.id)}
            onBook={() => openBookingModal(excursion, 'excursion')}
          />
        ))}
      </div>
    </div>
  );

  // Render Events Tab
  const renderEventsTab = () => (
    <div className="space-y-6">
      <h2 className="text-2xl text-gray-900 dark:text-white">Special Events</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {filteredEvents.map((event) => (
          <EventCard
            key={event.id}
            event={event}
            isFavorite={favorites.includes(event.id)}
            onToggleFavorite={() => toggleFavorite(event.id)}
            onBook={() => openBookingModal(event, 'event')}
          />
        ))}
      </div>
    </div>
  );

  // Render Services Tab
  const renderServicesTab = () => (
    <div className="space-y-6">
      <h2 className="text-2xl text-gray-900 dark:text-white">Additional Services</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {services.map((service) => (
          <div
            key={service.id}
            className="bg-white dark:bg-gray-800 rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all text-center group"
          >
            <div className="text-5xl mb-4 group-hover:scale-110 transition-transform">{service.icon}</div>
            <h3 className="text-xl text-gray-900 dark:text-white mb-2">{service.name}</h3>
            <p className="text-gray-600 dark:text-gray-400 mb-4">{service.description}</p>
            <button
              onClick={() => openServiceRequest(service)}
              className="w-full bg-gradient-to-r from-teal-500 to-teal-600 text-white py-3 rounded-xl hover:shadow-lg transition-all"
            >
              Request Service
            </button>
          </div>
        ))}
      </div>
    </div>
  );

  // Render Favorites Tab
  const renderFavoritesTab = () => (
    <div className="space-y-6">
      <h2 className="text-2xl text-gray-900 dark:text-white">My Favorites</h2>
      
      {favorites.length === 0 ? (
        <div className="text-center py-12">
          <Heart className="w-16 h-16 text-gray-300 dark:text-gray-600 mx-auto mb-4" />
          <h3 className="text-xl text-gray-600 dark:text-gray-400 mb-2">No favorites yet</h3>
          <p className="text-gray-500 dark:text-gray-500">Start adding excursions and events to your favorites!</p>
        </div>
      ) : (
        <>
          {favoriteExcursions.length > 0 && (
            <section>
              <h3 className="text-xl text-gray-900 dark:text-white mb-4">Favorite Excursions</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {favoriteExcursions.map((excursion) => (
                  <ExcursionCard
                    key={excursion.id}
                    excursion={excursion}
                    isFavorite={true}
                    onToggleFavorite={() => toggleFavorite(excursion.id)}
                    onBook={() => openBookingModal(excursion, 'excursion')}
                  />
                ))}
              </div>
            </section>
          )}

          {favoriteEvents.length > 0 && (
            <section>
              <h3 className="text-xl text-gray-900 dark:text-white mb-4">Favorite Events</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {favoriteEvents.map((event) => (
                  <EventCard
                    key={event.id}
                    event={event}
                    isFavorite={true}
                    onToggleFavorite={() => toggleFavorite(event.id)}
                    onBook={() => openBookingModal(event, 'event')}
                  />
                ))}
              </div>
            </section>
          )}
        </>
      )}
    </div>
  );

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
      {/* QR Scanner Modal */}
      {showQRScanner && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white dark:bg-gray-800 rounded-2xl p-8 max-w-md w-full shadow-2xl text-center">
            <div className="w-24 h-24 bg-gradient-to-br from-teal-500 to-teal-600 rounded-full flex items-center justify-center mx-auto mb-4">
              <QrCode className="w-12 h-12 text-white" />
            </div>
            <h2 className="text-2xl mb-3 text-gray-900 dark:text-white">Connect with Representative</h2>
            <p className="text-gray-600 dark:text-gray-400 mb-6">
              Scan your representative's QR code to get started
            </p>
            <div className="bg-gray-100 dark:bg-gray-700 rounded-xl p-8 mb-6">
              <div className="w-48 h-48 mx-auto bg-white dark:bg-gray-600 rounded-lg flex items-center justify-center">
                <QrCode className="w-32 h-32 text-gray-400" />
              </div>
            </div>
            <button
              onClick={() => setShowQRScanner(false)}
              className="w-full bg-gradient-to-r from-teal-500 to-teal-600 text-white py-3 rounded-xl hover:shadow-lg transition-all"
            >
              Close
            </button>
          </div>
        </div>
      )}

      {/* Search Bar */}
      <div className="mb-6">
        <div className="relative">
          <Search className="absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5" />
          <input
            type="text"
            placeholder="Search excursions, events, or services..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-12 pr-4 py-4 rounded-2xl border-2 border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all shadow-sm"
          />
        </div>
      </div>

      {/* Navigation Tabs */}
      <div className="mb-6 bg-white dark:bg-gray-800 rounded-2xl p-2 shadow-lg">
        <div className="grid grid-cols-5 gap-2">
          {[
            { id: 'home', icon: Home, label: 'Home' },
            { id: 'excursions', icon: Compass, label: 'Excursions' },
            { id: 'events', icon: Calendar, label: 'Events' },
            { id: 'services', icon: HeartHandshake, label: 'Services' },
            { id: 'favorites', icon: Heart, label: 'Favorites' }
          ].map((tab) => {
            const Icon = tab.icon;
            return (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id as TabType)}
                className={`flex flex-col items-center justify-center py-3 rounded-xl transition-all ${
                  activeTab === tab.id
                    ? 'bg-gradient-to-r from-teal-500 to-teal-600 text-white shadow-lg'
                    : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'
                }`}
              >
                <Icon className="w-5 h-5 mb-1" />
                <span className="text-xs">{tab.label}</span>
              </button>
            );
          })}
        </div>
      </div>

      {/* Tab Content */}
      {activeTab === 'home' && renderHomeTab()}
      {activeTab === 'excursions' && renderExcursionsTab()}
      {activeTab === 'events' && renderEventsTab()}
      {activeTab === 'services' && renderServicesTab()}
      {activeTab === 'favorites' && renderFavoritesTab()}

      {/* Booking Modal */}
      {bookingModal.isOpen && bookingModal.item && bookingModal.type && (
        <BookingModal
          isOpen={bookingModal.isOpen}
          onClose={() => setBookingModal({ isOpen: false, item: null, type: null })}
          item={bookingModal.item}
          type={bookingModal.type}
          isDarkMode={isDarkMode}
        />
      )}

      {/* Service Request Modal */}
      {serviceRequestModal.isOpen && serviceRequestModal.service && (
        <ServiceRequestModal
          isOpen={serviceRequestModal.isOpen}
          onClose={() => setServiceRequestModal({ isOpen: false, service: null })}
          service={serviceRequestModal.service}
          isDarkMode={isDarkMode}
        />
      )}
    </div>
  );
}

// Excursion Card Component
function ExcursionCard({ excursion, isFavorite, onToggleFavorite, onBook }: any) {
  return (
    <div className="bg-white dark:bg-gray-800 rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all group">
      <div className="relative h-56 overflow-hidden">
        <ImageWithFallback
          src={excursion.image}
          alt={excursion.name}
          className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
        <button
          onClick={onToggleFavorite}
          className="absolute top-4 right-4 bg-white/90 dark:bg-gray-800/90 backdrop-blur-sm p-2.5 rounded-full hover:bg-white dark:hover:bg-gray-800 transition-all shadow-lg z-10"
        >
          <Heart className={`w-5 h-5 ${isFavorite ? 'fill-red-500 text-red-500' : 'text-gray-600 dark:text-gray-300'}`} />
        </button>
        <div className="absolute top-4 left-4 bg-gradient-to-r from-teal-500 to-teal-600 text-white px-3 py-1.5 rounded-full text-sm shadow-lg">
          {excursion.category}
        </div>
        <div className="absolute bottom-4 left-4 flex items-center space-x-1 bg-white/90 dark:bg-gray-800/90 backdrop-blur-sm px-3 py-1.5 rounded-full">
          <Star className="w-4 h-4 text-yellow-500 fill-yellow-500" />
          <span className="text-sm text-gray-900 dark:text-white">{excursion.rating}</span>
        </div>
      </div>
      <div className="p-5">
        <h3 className="text-lg text-gray-900 dark:text-white mb-2">{excursion.name}</h3>
        <p className="text-sm text-gray-600 dark:text-gray-400 mb-3">{excursion.description}</p>
        <div className="flex items-center gap-3 text-sm text-gray-600 dark:text-gray-400 mb-4">
          <div className="flex items-center space-x-1">
            <MapPin className="w-4 h-4" />
            <span>{excursion.location}</span>
          </div>
          <div className="flex items-center space-x-1">
            <Clock className="w-4 h-4" />
            <span>{excursion.duration}</span>
          </div>
        </div>
        <div className="flex items-center justify-between">
          <div>
            <span className="text-2xl text-gray-900 dark:text-white">${excursion.price}</span>
            <span className="text-sm text-gray-500 dark:text-gray-400">/person</span>
          </div>
          <button
            onClick={onBook}
            className="bg-gradient-to-r from-orange-500 to-orange-600 text-white px-6 py-2.5 rounded-xl hover:shadow-lg transition-all"
          >
            Book Now
          </button>
        </div>
      </div>
    </div>
  );
}

// Event Card Component
function EventCard({ event, isFavorite, onToggleFavorite, onBook }: any) {
  return (
    <div className="bg-white dark:bg-gray-800 rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all group">
      <div className="relative h-56 overflow-hidden">
        <ImageWithFallback
          src={event.image}
          alt={event.name}
          className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent"></div>
        <button
          onClick={onToggleFavorite}
          className="absolute top-4 right-4 bg-white/90 dark:bg-gray-800/90 backdrop-blur-sm p-2.5 rounded-full hover:bg-white dark:hover:bg-gray-800 transition-all shadow-lg z-10"
        >
          <Heart className={`w-5 h-5 ${isFavorite ? 'fill-red-500 text-red-500' : 'text-gray-600 dark:text-gray-300'}`} />
        </button>
        <div className="absolute top-4 left-4 bg-gradient-to-r from-orange-500 to-red-500 text-white px-3 py-1.5 rounded-full text-sm shadow-lg">
          {event.category}
        </div>
        <div className="absolute bottom-4 left-4 right-4">
          <h3 className="text-2xl text-white mb-2">{event.name}</h3>
          <div className="flex flex-wrap items-center gap-3 text-white/90 text-sm">
            <div className="flex items-center space-x-1">
              <Calendar className="w-4 h-4" />
              <span>{event.date}</span>
            </div>
            <div className="flex items-center space-x-1">
              <MapPin className="w-4 h-4" />
              <span>{event.location}</span>
            </div>
          </div>
        </div>
      </div>
      <div className="p-5">
        <p className="text-sm text-gray-600 dark:text-gray-400 mb-4">{event.description}</p>
        <div className="flex items-center justify-between">
          <div>
            <span className="text-2xl text-gray-900 dark:text-white">${event.price}</span>
            <span className="text-sm text-gray-500 dark:text-gray-400">/person</span>
          </div>
          <button
            onClick={onBook}
            className="bg-gradient-to-r from-teal-500 to-teal-600 text-white px-6 py-2.5 rounded-xl hover:shadow-lg transition-all"
          >
            Book Now
          </button>
        </div>
      </div>
    </div>
  );
}
