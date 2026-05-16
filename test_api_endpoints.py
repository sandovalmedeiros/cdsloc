"""Test API endpoints."""
import requests
import json

BASE_URL = "http://localhost:8000"

def test_root_endpoint():
    """Test root endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/")
        print(f"✓ Root endpoint: {response.status_code}")
        print(f"  Response: {response.json()}")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Root endpoint failed: {e}")
        return False

def test_health_endpoint():
    """Test health endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/health")
        print(f"✓ Health endpoint: {response.status_code}")
        print(f"  Response: {response.json()}")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Health endpoint failed: {e}")
        return False

def test_docs_endpoint():
    """Test docs endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/docs")
        print(f"✓ Docs endpoint: {response.status_code}")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Docs endpoint failed: {e}")
        return False

def test_customers_list():
    """Test customers list endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/customers")
        print(f"✓ Customers list: {response.status_code}")
        if response.status_code == 200:
            customers = response.json()
            print(f"  Found {len(customers)} customers")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Customers list failed: {e}")
        return False

def test_dashboard_stats():
    """Test dashboard stats endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/dashboard/stats")
        print(f"✓ Dashboard stats: {response.status_code}")
        if response.status_code == 200:
            stats = response.json()
            print(f"  Stats: {json.dumps(stats, indent=2)}")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Dashboard stats failed: {e}")
        return False

def test_catalog_list():
    """Test catalog list endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/catalog/titulos")
        print(f"✓ Catalog list: {response.status_code}")
        if response.status_code == 200:
            titles = response.json()
            print(f"  Found {len(titles)} titles")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Catalog list failed: {e}")
        return False

def test_rentals_list():
    """Test rentals list endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/rentals")
        print(f"✓ Rentals list: {response.status_code}")
        if response.status_code == 200:
            rentals = response.json()
            print(f"  Found {len(rentals)} rentals")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Rentals list failed: {e}")
        return False

def test_reservations_list():
    """Test reservations list endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/reservas")
        print(f"✓ Reservations list: {response.status_code}")
        if response.status_code == 200:
            reservations = response.json()
            print(f"  Found {len(reservations)} reservations")
        return response.status_code == 200
    except Exception as e:
        print(f"✗ Reservations list failed: {e}")
        return False

if __name__ == "__main__":
    print("Testing API Endpoints")
    print("=" * 50)

    results = []

    # Basic endpoints
    print("\n1. Basic Endpoints:")
    results.append(test_root_endpoint())
    results.append(test_health_endpoint())
    results.append(test_docs_endpoint())

    # Business endpoints
    print("\n2. Business Endpoints:")
    results.append(test_customers_list())
    results.append(test_dashboard_stats())
    results.append(test_catalog_list())
    results.append(test_rentals_list())
    results.append(test_reservations_list())

    # Summary
    print("\n" + "=" * 50)
    passed = sum(results)
    total = len(results)
    print(f"Tests passed: {passed}/{total}")

    if passed == total:
        print("✓ All tests passed!")
        exit(0)
    else:
        print("✗ Some tests failed")
        exit(1)