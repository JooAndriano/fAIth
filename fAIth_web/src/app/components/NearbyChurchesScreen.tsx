import {
  MapPin,
  Navigation,
  Phone,
  Globe,
  ChevronRight,
} from "lucide-react";

export default function NearbyChurchesScreen() {
  const churches = [
    {
      id: 1,
      name: "Grace Community Church",
      denomination: "Non-denominational",
      distance: "0.8 miles",
      address: "123 Main Street",
      phone: "(555) 123-4567",
      services: "Sun 9am, 11am",
    },
    {
      id: 2,
      name: "First Baptist Church",
      denomination: "Baptist",
      distance: "1.2 miles",
      address: "456 Oak Avenue",
      phone: "(555) 234-5678",
      services: "Sun 10:30am",
    },
    {
      id: 3,
      name: "St. Mary's Catholic Church",
      denomination: "Catholic",
      distance: "1.5 miles",
      address: "789 Church Road",
      phone: "(555) 345-6789",
      services: "Sat 5pm, Sun 8am, 10am",
    },
    {
      id: 4,
      name: "Cornerstone Fellowship",
      denomination: "Evangelical",
      distance: "2.1 miles",
      address: "321 Faith Lane",
      phone: "(555) 456-7890",
      services: "Sun 10am",
    },
  ];

  return (
    <div className="h-screen w-full bg-background overflow-y-auto pb-20">
      {/* Header */}
      <div className="bg-gradient-to-br from-navy to-[#0f1419] text-ivory p-6 pb-8 rounded-b-2xl shadow-lg">
        <h1 className="text-2xl mb-2">Nearby Churches</h1>
        <div className="flex items-center gap-2 text-beige/70 text-sm">
          <MapPin className="w-4 h-4" />
          <span>Based on your location</span>
        </div>
      </div>

      <div className="p-6 space-y-4">
        {/* Map placeholder */}
        <div className="bg-gradient-to-br from-gold/10 via-muted to-sunset/10 rounded-2xl h-48 flex items-center justify-center border border-border shadow-sm relative overflow-hidden">
          <div className="absolute inset-0 opacity-20">
            <div className="absolute top-8 left-12 w-3 h-3 bg-gold rounded-full animate-pulse" />
            <div
              className="absolute top-16 right-16 w-3 h-3 bg-sunset rounded-full animate-pulse delay-100"
              style={{ animationDelay: "0.1s" }}
            />
            <div
              className="absolute bottom-12 left-1/3 w-3 h-3 bg-gold rounded-full animate-pulse delay-200"
              style={{ animationDelay: "0.2s" }}
            />
            <div
              className="absolute bottom-16 right-1/4 w-3 h-3 bg-sunset rounded-full animate-pulse delay-300"
              style={{ animationDelay: "0.3s" }}
            />
          </div>
          <div className="text-center z-10">
            <MapPin className="w-12 h-12 text-gold mx-auto mb-2" />
            <p className="text-sm text-muted-foreground">
              Interactive map view
            </p>
          </div>
        </div>

        {/* Churches list */}
        <div className="space-y-3">
          <h3 className="text-navy px-1">Churches Near You</h3>

          {churches.map((church) => (
            <div
              key={church.id}
              className="bg-card border border-border rounded-2xl p-5 shadow-sm hover:shadow-md transition-all cursor-pointer"
            >
              <div className="flex items-start gap-4">
                {/* Church icon/image placeholder */}
                <div className="w-16 h-16 bg-gradient-to-br from-gold/20 to-sunset/20 rounded-xl flex items-center justify-center flex-shrink-0">
                  <MapPin className="w-8 h-8 text-gold" />
                </div>

                <div className="flex-1 min-w-0">
                  <div className="flex items-start justify-between gap-2 mb-2">
                    <div className="flex-1">
                      <h4 className="text-navy truncate">
                        {church.name}
                      </h4>
                      <div className="flex items-center gap-2 mt-1">
                        <span className="text-xs text-gold">
                          {church.distance}
                        </span>
                      </div>
                    </div>
                  </div>

                  <div className="space-y-1.5 text-xs text-muted-foreground">
                    <p className="flex items-center gap-2">
                      <MapPin className="w-3.5 h-3.5" />
                      {church.address}
                    </p>
                    <p className="flex items-center gap-2">
                      <Phone className="w-3.5 h-3.5" />
                      {church.phone}
                    </p>
                    <p className="text-navy mt-2">
                      Services: {church.services}
                    </p>
                  </div>

                  <div className="flex gap-2 mt-4">
                    <button className="flex-1 bg-gradient-to-br from-gold to-sunset text-ivory rounded-xl px-4 py-2.5 text-sm hover:shadow-lg transition-all active:scale-98 flex items-center justify-center gap-2">
                      <Navigation className="w-4 h-4" />
                      Get Directions
                    </button>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}